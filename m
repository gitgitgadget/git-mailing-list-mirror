From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: import determinism
Date: Wed, 10 Nov 2010 16:25:40 -0500
Message-ID: <AANLkTin-SxiTMZOeucS5_KKpaCz=PJ3yWjPFxB0bhCQ2@mail.gmail.com>
References: <20101107202535.GA18766@nibiru.local> <AANLkTi=mx0AAKo2Asn5XJVcs30-PLuwhTbM=o0y36Wa_@mail.gmail.com>
 <m2lj54u9uj.fsf@igel.home> <AANLkTikXxM=CfU2dKAY9khi1_tAsGDdUEc8S5AxooGH9@mail.gmail.com>
 <m2d3qgu50c.fsf@igel.home> <20101109134337.GA19430@nibiru.local>
 <AANLkTi=y_DKRRU43ro3WDz2rSDGL9xASfsinoj8Ya9PT@mail.gmail.com> <20101110161804.GA29619@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: weigelt@metux.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 22:26:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGIBG-00071F-KE
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 22:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756889Ab0KJV0E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Nov 2010 16:26:04 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33909 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756859Ab0KJV0C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Nov 2010 16:26:02 -0500
Received: by yxt33 with SMTP id 33so223727yxt.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 13:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=dMbxZzhRjKX5uMXKqiX8FJbG/Ic72yZgR7PtROrhAX0=;
        b=P1Np/S5WeSpOXHMEvc/xUp86AOx6qYizGvHqH+4XpEl8GOGYa6aBAD+JBpYxCZs5NZ
         10xhiX+GpTaDW8UYNAj70wgKgfa7tS67ccyxg/fiMHjt1WEgqe+z3XTj3hEyt+2PcqeL
         6iuTznkQbZWKM0qahWMGEbusQvSAx5N6w12kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=FC/EY+J9j7BsKU/SUGhEqfrACMDYjnOlAlEYJA5f45vFkDWVvpvIrJDLXK7GWFHc9t
         +e40KThviW1CnU4pYHPxMDNHZcIvoB8qMkkxacJJXnU6UptC2voFlPcMcKguAi8W86l+
         n4H47yJotf0LWUEhQKKlVsrOcZjX1Zygl+WU8=
Received: by 10.42.220.69 with SMTP id hx5mr17389icb.519.1289424360806; Wed,
 10 Nov 2010 13:26:00 -0800 (PST)
Received: by 10.231.16.65 with HTTP; Wed, 10 Nov 2010 13:25:40 -0800 (PST)
In-Reply-To: <20101110161804.GA29619@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161187>

On Wed, Nov 10, 2010 at 11:18 AM, Enrico Weigelt <weigelt@metux.de> wro=
te:
> * Martin Langhoff <martin.langhoff@gmail.com> wrote:
>> Every full clone is a good backup. If nobody is doing a full clone..=
=2E
>> the do back them up. That's my recommendation.
>
> Does the clone have all information necessary for the incremental
> cvsimport runs ?

Yes -- all cvsimport tracks is the branches. No extra import-tracking
data is maintained. (Other importers may or may not keep additional
data, YMMV, etc)


m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- School Server Architect
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
