From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 3/4] git-push: make git push --porcelain print "Done"
Date: Sat, 27 Feb 2010 13:22:58 +0800
Message-ID: <be6fef0d1002262122u1a7396f4jefbab1cb9a484229@mail.gmail.com>
References: <cover.1267245870.git.larry@elder-gods.org>
	 <22ec18ddf7cc504addf7929e2543c60d836d2467.1267245870.git.larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Larry D'Anna" <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Sat Feb 27 06:23:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlF94-0001cX-UE
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 06:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029Ab0B0FXB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2010 00:23:01 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:37405 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab0B0FXA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Feb 2010 00:23:00 -0500
Received: by iwn12 with SMTP id 12so866422iwn.21
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 21:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=b/Y1Bkoq2R527DWIGc0jeCV7gqHOy2QXCWeQeK+vrFI=;
        b=uYW7qJ0NGCmO8QC4uyD16tpRm7xHb90QbVZYI7jhdAQYePOWeQgKAXvDiBCZEzz+tL
         uetN76DdfWeePTERdvRWA1bJla1SewH8kpi8MRGyPtLMJVSopC+0TBhPtfyajk0gKoq0
         KDGEvRW51u4QyzeudG0p9MtrNa/LfHyMlHR/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tqLFcANWeKaznE+sCOY7bEKwr96ihm6ySnPXRaoAiND3mkiY85O7nnE4IVXNkY7GOw
         C3vM4Pf8iZ/+XbQaHrWcraduZyMKCvDWtrbtRgKbrh+TD/Hb8G4TqbbfhgBuDUInn8wt
         6OpU97lI4T8Iw7bhjKoqTI4kesNtB4W1I7b4w=
Received: by 10.231.151.207 with SMTP id d15mr1061115ibw.44.1267248178149; 
	Fri, 26 Feb 2010 21:22:58 -0800 (PST)
In-Reply-To: <22ec18ddf7cc504addf7929e2543c60d836d2467.1267245870.git.larry@elder-gods.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141189>

Hi,

On Sat, Feb 27, 2010 at 12:52 PM, Larry D'Anna <larry@elder-gods.org> w=
rote:
> The script calling git push --porcelain --dry-run can see clearly fro=
m the
> output if an update was rejected. =A0However, it will probably need t=
o distinguish
> this condition from the push failing for other reasons, such as the r=
emote not
> being reachable.
>
> This patch modifies git push --porcelain to print "Done" after the re=
st of its
> output unless any errors have occurred. =A0For the purpose of the "Do=
ne" line,
> knowing a ref will be rejected in a --dry-run does not count as an er=
ror.
> Actual rejections in non --dry-run pushes do count as errors.
>
> Signed-off-by: Larry D'Anna <larry@elder-gods.org>

Acked-by: Tay Ray Chuan <rctay89@gmail.com>

--=20
Cheers,
Ray Chuan
