From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Tue, 8 Jan 2013 21:28:41 +0700
Message-ID: <CACsJy8BJ3eBv-wjq=eTzR4SeEXW2MF5k1w5SFRt7fWRU4vKb_Q@mail.gmail.com>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
 <20130108062811.GA3131@elie.Belkin> <7vip78go6b.fsf@alter.siamese.dyndns.org> <7vd2xggm8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 15:29:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsaBI-0008Qm-K7
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 15:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429Ab3AHO3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 09:29:13 -0500
Received: from mail-oa0-f50.google.com ([209.85.219.50]:43191 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756417Ab3AHO3M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 09:29:12 -0500
Received: by mail-oa0-f50.google.com with SMTP id n16so421476oag.9
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 06:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dCMAIqV8isFN9/b/cb02n9t28eAEV5yWYhg8tVTfx5I=;
        b=k6lYeMSYiWl1RR9y+M6vLmOZJnElqIcMlSZi60Eo5wLX70UuV0An0g96gFCl+2KY9B
         8GQKTa1MNTe6R7cCeaGKnrDb/c3ZrTAWG30XdCVl2FSRiFK7by+iV27AGOhZM+Y1xQ+H
         CXP/Rgw2c/uvVm1lqqXxnlLyUO852fVzeE2bc00tBJ/2LRLO0o5y+eDTQLNndKcWDhax
         9FMZ0jXbI6tn9MIAHhEwY8Zu4mU94HRBJjJCmQIHgNcE/pEUnJnnQBYQW7k43qasJMC6
         u3egceQVLZf0CcRGRP+wQOUb6YyTWDFYmu/Kp4VPMYBf7t6qzK0yt+jRIkrAw8EC4UOS
         M4Yw==
Received: by 10.182.159.5 with SMTP id wy5mr44805623obb.31.1357655351106; Tue,
 08 Jan 2013 06:29:11 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Tue, 8 Jan 2013 06:28:41 -0800 (PST)
In-Reply-To: <7vd2xggm8a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212965>

On Tue, Jan 8, 2013 at 2:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Speaking of --depth, I think in Git 2.0 we should fix the semantics
> of "deepening" done with "git fetch".

Speaking of 2.0, we should support depth per ref. Well we don't have
to wait until 2.0 because we could just add shallow2 extension to the
pack protocol. We should also apply depth to new refs when fetching
them the first time.
-- 
Duy
