From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: patches in context format ?
Date: Mon, 12 Jan 2009 10:52:23 +0100
Message-ID: <46d6db660901120152g31d33bfevcd592ae360252804@mail.gmail.com>
References: <46d6db660901120100g7f62a0c2k68c96cbfc23dab5@mail.gmail.com>
	 <7vy6xgj2jq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 10:53:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMJUU-0003cP-06
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 10:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbZALJw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 04:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbZALJw0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 04:52:26 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:44171 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbZALJwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 04:52:25 -0500
Received: by bwz14 with SMTP id 14so31813671bwz.13
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 01:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=npyeqG6MhXqS2z2q2FOpIw1K47pxIHnxAvekkwuJg/g=;
        b=BHCEZ8RlvbL7fAnJQe+yuvLfgSe3CSJP0Q8BglxEEzrYcmYkBYK+GyNuEUTlZZCOn6
         MX9DuE0n8mbfIY1dPFEIbNg74bzEXmZkBDpD/NVlSQ+r2dLdbNg9CwNtsMktpYGs3yG4
         yublv4z+GHeLliGy+q2d6OaUldhv0mtZAdgfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uPjtJymmACXhExtHkMIFPlGyzXKvhdiH9Cho7UOJ4bGDXIkWCj0tLQ8c2gyq7bV+NQ
         UYepkcJRU9IKxPKcRsS/DBkj0yMvVvuYOYZ6hgXOpHc7CXc5HzwR/DYuHqKFdXqCEfAO
         WftrHx6zIvx4ihRxTmtQ7lipLKusBH95cf6S8=
Received: by 10.103.92.8 with SMTP id u8mr9534177mul.12.1231753943156;
        Mon, 12 Jan 2009 01:52:23 -0800 (PST)
Received: by 10.103.118.7 with HTTP; Mon, 12 Jan 2009 01:52:23 -0800 (PST)
In-Reply-To: <7vy6xgj2jq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105318>

On Mon, Jan 12, 2009 at 10:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I guess the answer is no, but has anyone on the list been working on
>> this ? is there another way to translate from "context" to "unified"
>> format ?
>
> Not that I know of.
>
> If you want to add support for the copied context format patches to your
> workflow, I think the first step (and easiest one) would be to find an
> external program that lets you convert from the copied context format to
> the unified context format.  Perhaps "interdiff /dev/null copied >unified"
> would suffice (but I haven't tested this).
>

interdiff is exactly what I needed (I used -p and -q switches, plus a
substitution for the path).

Thanks for this! I guess there's not really a need to add this now in
git-am, since I've seldom seen such context patches.

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
