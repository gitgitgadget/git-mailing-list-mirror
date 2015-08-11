From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/5] pseudorefs: create and use pseudoref update and delete functions
Date: Tue, 11 Aug 2015 15:32:33 -0700
Message-ID: <xmqqh9o5o3r2.fsf@gitster.dls.corp.google.com>
References: <1438322781-21181-1-git-send-email-dturner@twopensource.com>
	<1438322781-21181-3-git-send-email-dturner@twopensource.com>
	<CAGZ79kZ-e-GU5FfKWDAUxQPUnyrmGjSvHGnjWn=pwpDAj37umQ@mail.gmail.com>
	<1439318789.5283.23.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 00:32:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPI64-0002CW-R1
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 00:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbbHKWcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 18:32:36 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35806 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbbHKWcf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 18:32:35 -0400
Received: by pdrg1 with SMTP id g1so88182560pdr.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 15:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wtc+755ZS0MrhEdcq0SKnGfQnGdWh4E53VhbjON7hmY=;
        b=wHgOU3xjxIx05vL6h+Bw0S/BwR7857bmrBp/n9xtyBj0kD6SXDqDb2fIN/htdIkQAw
         KRiOcVw24e1USrI8o76ZvHnqOGcAfwj85FBd8VHjpO7QDYIzCE7ClTuqSuyiD2l6mXUc
         b77BiEbgENFZMQqwpMJggfSJJfWY1ebS0udorX9JMd+0j5CQCKIsUDkHJZf9lgtLsPED
         KIZPiniaRr3pW5jCqaxlXwBbHA+vcfYsZOTm3iXY3KW3ejdz08Yl7g1aq+UtMeum6z9A
         DnHWf5CNv/wa+LKOtyCUE1ctuuVBUuUdVLXL8RFFOlyXqXoiORVkxjXNiE3RGD3fR82F
         m1cw==
X-Received: by 10.70.123.132 with SMTP id ma4mr61625448pdb.92.1439332355038;
        Tue, 11 Aug 2015 15:32:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id c1sm3911153pbu.30.2015.08.11.15.32.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 15:32:33 -0700 (PDT)
In-Reply-To: <1439318789.5283.23.camel@twopensource.com> (David Turner's
	message of "Tue, 11 Aug 2015 14:46:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275738>

David Turner <dturner@twopensource.com> writes:

> On Fri, 2015-07-31 at 16:40 -0700, Stefan Beller wrote:
>> I am sorry for being late to the review, I looked into coverity today as Duy
>> bugged me to fix the memory allocation stuff[1]
>
> Thanks. Junio, can you pleas substitute the attached patch instead?

No.  The topic is already in 'next', no?
