From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] {fetch,receive}-pack: skip sha-1 integrity test on
 objects from new pack
Date: Fri, 16 Mar 2012 10:42:39 +0700
Message-ID: <CACsJy8DcwjgdU5j_6LMbhwFJQXg+M=C3S_-UcRBsF3WyYZ6z7A@mail.gmail.com>
References: <7vfwdq8914.fsf@alter.siamese.dyndns.org> <1331736055-21019-1-git-send-email-pclouds@gmail.com>
 <7vy5r1inax.fsf@alter.siamese.dyndns.org> <7vsjh9il3l.fsf@alter.siamese.dyndns.org>
 <CACsJy8D5UNd5b=Dpt75Qrc96u6wRLffB7eGSsKqM3qQ37p4cOw@mail.gmail.com> <7v4ntpi54l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 04:43:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8O4W-0004HM-Aw
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 04:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031289Ab2CPDnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 23:43:14 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:47645 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031128Ab2CPDnL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 23:43:11 -0400
Received: by wejx9 with SMTP id x9so3505180wej.19
        for <git@vger.kernel.org>; Thu, 15 Mar 2012 20:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=D7Ms3RLxmyNT4Xvdwr9cvxzxxiqd5hItr56KkbT2Mbs=;
        b=SL11kBYTfNDlLedHcjgDZq9EsuCJGmkUeVjm5e0iEI6bsz1dfbln0g8SI7TLT+clCS
         TwvtXkN1FkZzrVcQLM+ZzCD/+cIp/9r3pfmW3UZmUzeL+9nQeUTzTwr34ZcAI3zbjudw
         DFilbu2V3O3nGnHt+DELDhZvoncvilRcldohGpBbFnV2lGga6YDTwpWH/BNTyCz0LAU8
         4QYo96SRKbP9XTV72ELhmyz+JxTarwaU+SajDED5sEfsBG4G/bjvCRAvUmmw7aZpShz3
         kxKvr9jONKJ9diTjCO2W7VS/WO9z9UK0HgvTgXCbMDFatCQHeLlwEO98ipFIygt7KcKx
         IrXA==
Received: by 10.180.98.8 with SMTP id ee8mr2785291wib.14.1331869390592; Thu,
 15 Mar 2012 20:43:10 -0700 (PDT)
Received: by 10.223.13.5 with HTTP; Thu, 15 Mar 2012 20:42:39 -0700 (PDT)
In-Reply-To: <7v4ntpi54l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193241>

On Fri, Mar 16, 2012 at 10:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> What about push/receive-pack? I think the same thing happens there.
>
> As the patch goes to check_everything_connected(), it is automatically
> covered, no?

Yeah right, sorry stupid question.
-- 
Duy
