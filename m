From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [1.8.0] make two-argument fetch update remote branches
Date: Tue, 1 Feb 2011 22:58:11 +0700
Message-ID: <AANLkTinns+M1=50jj7RAFnnp6-WPv+CpuWkO0xq_qko9@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <201101312244.10047.trast@student.ethz.ch> <AANLkTi=Y9PBs_jXyCiAL9YLA8Y_jzWwqxw63hKm7fVBO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 16:58:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkIcy-0006em-Ix
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 16:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914Ab1BAP6n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 10:58:43 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:55797 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab1BAP6n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 10:58:43 -0500
Received: by wwi17 with SMTP id 17so4922676wwi.1
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 07:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=wrW86zPojvhQNtAEoBW3ajSDQ7yN0DjOCEanzZiFmCw=;
        b=dDh99a933AlSe8pTfFCkfq4xYnvGq8Ou1sQCKilZPP9GHvktX9dqCZKm0rUHN3psod
         w67Bq63ht3X38Tarz24iLfTeMgnGH18RBN9XfY6t86rtvBS1hMcfvkBAGOn9mU83VVbM
         tGeAL2fRCQHqvhTBiFN3RykIy4ztCrXr81ZKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SNvlzRAF5hvKjZbi/M7vSo8DQQzeDkSmPreCpU4Br2uSsif26W/uFqSgyKosBRSdWt
         aY5LmE1jqi9JvNT9qLAWptxppD7K7Lfl3S5cbcwygVo0vDdEvOxNDrAFsjzMSDhe9Xpy
         E8ppo5YFK4ksiDghN7gsiCbl7qGWu9HjH1Ves=
Received: by 10.216.242.136 with SMTP id i8mr7504952wer.19.1296575921636; Tue,
 01 Feb 2011 07:58:41 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Tue, 1 Feb 2011 07:58:11 -0800 (PST)
In-Reply-To: <AANLkTi=Y9PBs_jXyCiAL9YLA8Y_jzWwqxw63hKm7fVBO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165820>

On Tue, Feb 1, 2011 at 2:04 PM, Jay Soffian <jaysoffian@gmail.com> wrot=
e:
> On Mon, Jan 31, 2011 at 4:44 PM, Thomas Rast <trast@student.ethz.ch> =
wrote:
>> Add a fetch.updateRemoteNamespace (or so) configuration variable tha=
t
>> defaults to false. =C2=A0When enabled, it turns on the auto-updating
>> behaviour.
>
> Would it make sense to group the pre-1.8 compatibility switches
> together in some way, if there will be several of them? Maybe
>
> [compat]
> =C2=A0 fetchUpdateRemoteNamespace =3D false
> =C2=A0 ...

It is. I was thinking of it as a group of "short"-lived configs to
help maintain backward compatibility for some time (not for ever)
until users are forced to migrate.
--=20
Duy
