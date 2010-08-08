From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: git log --stat FILE
Date: Sun, 8 Aug 2010 13:54:59 +0200
Message-ID: <AANLkTikKwp9gS9nt=JnsdyXMgx+PxrhHhNFftYFqX+M_@mail.gmail.com>
References: <yf9wrs1fili.fsf@chiyo.mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marcus Comstedt <marcus@mc.pp.se>
X-From: git-owner@vger.kernel.org Sun Aug 08 13:55:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi4T7-00022B-FC
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 13:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692Ab0HHLzB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 07:55:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47796 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620Ab0HHLzA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Aug 2010 07:55:00 -0400
Received: by mail-fx0-f46.google.com with SMTP id 14so4556359fxm.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 04:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MyGsel/fyxd6+xZoOUmuyZlPNfLwIx/rWRn1Yx8iaKk=;
        b=icN0rpoxbIucEo9vnAf8iwtfheiavNcsMIJTkmMaI18Wh60cuf1jC09Jiqth9K4KYV
         bVuyJu7WUmIF5bqF1zkEDrRGBqwT23NeOXpce5ugntkgsfC7Smu/pzc0By2aL3oEOobG
         gaKLpYpwu1TjsoYtXB0NO3uOfA/5zJM+0cIAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nYOwLmrCm6AZB7RqsRgrC5fuiqu1dx71XH7fdMw8Onsa6Al0trMZH1oElCyV82Iwf1
         EO+cNTZKC3V+dLN2Z1USN43bs3IAW5jYreCVFbykTPPLjgqBhLZJwgNn/Gp/7xot5kGn
         A4msl8GJUO/057vdyqDqeU4u0grPF8EOA133o=
Received: by 10.239.185.197 with SMTP id d5mr802442hbh.12.1281268499268; Sun, 
	08 Aug 2010 04:54:59 -0700 (PDT)
Received: by 10.239.165.79 with HTTP; Sun, 8 Aug 2010 04:54:59 -0700 (PDT)
In-Reply-To: <yf9wrs1fili.fsf@chiyo.mc.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152901>

On Sun, Aug 8, 2010 at 13:29, Marcus Comstedt <marcus@mc.pp.se> wrote:
> When I do "git log --stat FILE", then only commits which touch FILE
> are displayed, as expected. =C2=A0However, contrary to expectation (w=
ell,
> my expectation at least), the stat shows that only one file (FILE) is
> modified by the commits, even if they actually modified multiple file=
s.
> That's not what I wanted;

Try adding --full-diff to your `git log` incantation.

--
larsh
