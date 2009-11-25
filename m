From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 15:56:49 +0100
Message-ID: <fabb9a1e0911250656k31229c42jd79fb94c1a619e59@mail.gmail.com>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 15:57:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDJIz-000614-Hq
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 15:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbZKYO5F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 09:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974AbZKYO5E
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 09:57:04 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:47989 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbZKYO5D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 09:57:03 -0500
Received: by vws30 with SMTP id 30so2143293vws.33
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 06:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=89pKD1Se2F3YWfw0PeKYEMy2Sy/4TMeCYZZC32N5B5A=;
        b=mRC/J317zuTgKtFXDUDjrShXb0bugkKBQ1BZcxkWvI+gsi6fQQdn6cAm+jpva4wU7G
         Yw0OV9G+pbtg0t6G8D2gLnQqgw0YEfTNWStGIWtcdxuSt38pyRYbgDDcpwSIW1zvcXYx
         cPpdDejU3hya5TgE5snzkxy/5V2bGn9c0c0wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DcjHHhatQ/ZC/8PE46IBGF5Eh+wjWlCl89GLdzIDaS1cBDaj6DepshqH0w/vqBiEaW
         mDpsvbv8WYmRfDqDVyFk9/UhxyR9LJdSkigdzALLUXvSSWVYIpTXypGHSQb0qQMerjpq
         MAPUM3pb+MGArUfkWGzDjny0LWG0oojJRvjK8=
Received: by 10.220.121.144 with SMTP id h16mr9273216vcr.53.1259161029124; 
	Wed, 25 Nov 2009 06:57:09 -0800 (PST)
In-Reply-To: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133646>

Heya,

On Tue, Nov 24, 2009 at 09:56, Junio C Hamano <gitster@pobox.com> wrote=
:
> =A0 I am not sure if there can be a sane way to flip the default with=
out
> =A0 hurting existing scripts and users. =A0Backward compatibility alw=
ays is
> =A0 a pain.

I regularly rely on this behavior in my usage of git grep. For
example, the Melange project has this layout:
-- app
-- app/soc
-- app/django
-- app/... etc
-- scripts
-- tests
-- thirdparty

I almost always want only results from "app/soc", so when I run git
grep I do so from within "app/soc" to make sure I don't get false
positives from the many external sources we have.

Just chiming in for the "want to keep the current behavior" camp :).

PS: I don't mind having to set a config variable to keep the current
behavior though.

--=20
Cheers,

Sverre Rabbelier
