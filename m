From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 2/4] Add prereq to detect OS X
Date: Sun, 4 Oct 2015 11:46:08 -0700
Message-ID: <580774DE-807D-411C-B6B4-A72D273038C1@gmail.com>
References: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com> <1443981977-64604-3-git-send-email-larsxschneider@gmail.com> <xmqq612m1oay.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, luke@diamand.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 20:46:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZioIa-0001Nn-9o
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 20:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbbJDSqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 14:46:12 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38152 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbbJDSqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 14:46:11 -0400
Received: by wiclk2 with SMTP id lk2so87776508wic.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1HX65ERw5AGgXNMz0rtlOIHcjjbguweMmu9+kRWnLl4=;
        b=rEyYIzFferDYuOLDFCciWhSA/HtXJHtJEned9YheICCIRwHRVPcw4sdTj7AcjUpvoo
         KEPktUJIWkXyswlSqbyZ0qRFP0oNe0IHutMadXgzNDPxUF0OD/8iURjATdmq0C7L8ZrA
         tGAIwV71OwAyjqYreQ5yBHXMFLNVExA7REHJDWXmP5QK61r3InIReqgV5bk5LyIAI2GU
         jg7nDHKFQjtL+lKzpsMWssEwmKclNe5lHoF+BwZnw1NkK1OyMe/+Vj+6MxfV76XEWPm9
         KVaY+hSYvleGKrxAJfj9ClmTt/JY6ApF5OmJ3c1Cd8vcPH0OPpVT6q8+pm6UkjlACytZ
         0l9Q==
X-Received: by 10.194.158.68 with SMTP id ws4mr29809384wjb.25.1443984370229;
        Sun, 04 Oct 2015 11:46:10 -0700 (PDT)
Received: from remdbq1n32.ads.autodesk.com (adsk-nat-ip3.autodesk.com. [132.188.71.3])
        by smtp.gmail.com with ESMTPSA id d8sm14372153wiy.1.2015.10.04.11.46.08
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 04 Oct 2015 11:46:09 -0700 (PDT)
In-Reply-To: <xmqq612m1oay.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279022>


On 04 Oct 2015, at 11:28, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Some Unix tools differ between Linux and Mac OS X. Add this prereq to
>> detect OS X and handle it appropriately.
> 
> If my comment on 4/4 turns out to be to the point, then we do not
> need this, I presume?  In general, we really should think three
> times before adding prerequisite based on the platform.  A prereq
> based on a specific feature of the platform is often what we want
> instead.
Agreed. I will remove this commit in the next roll.

Thanks,
Lars
