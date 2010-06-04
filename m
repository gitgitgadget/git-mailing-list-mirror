From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: Installing on AIX fails
Date: Fri, 4 Jun 2010 18:03:36 -0300
Message-ID: <AANLkTikDZ1r4vMDbKpQu1ljH3X7prjJfYpBnruiVrKIE@mail.gmail.com>
References: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
	<AANLkTik_FI0CETWZZcu8O8MQQx5oV6YAbt5-X0ozbVmw@mail.gmail.com>
	<AANLkTikkGtRmbsKD3JnQEWrhXQexH7J6SWEd9Aq3iQU_@mail.gmail.com>
	<AANLkTilnFXUI9hnVJlAylCzTUqOStZAFvtgvNrh8Kisj@mail.gmail.com>
	<AANLkTinLCLnpy5fkajsF5ICd97UtDB_q7T-kD4J-hFF4@mail.gmail.com>
	<AANLkTin6tFu9vgRVGFa2nF6PL1PUE7Zmd0t5uenyCkEz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tor Arntsen <tor@spacetec.no>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 23:03:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKe3U-0006Xz-EU
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 23:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab0FDVDj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 17:03:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37805 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108Ab0FDVDh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jun 2010 17:03:37 -0400
Received: by fxm8 with SMTP id 8so1097269fxm.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 14:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Drklor/P8RXgr7TpuD9zE1ZfTVX/HUNZdKESgVyjtXA=;
        b=b1GOZ6wzNwoF2ikDULu77/pFeGZXJ64HNBI30l805EtZBCirPKfxf9GxeK6hw3GDGP
         nHl4vFB+QBq8QhQ9kNifas6KkaYW0GPIZOYGZNlFFjVjQI/GDyd5VQlKH1aynGY64Y8a
         nbN+PJGinPdl0vNI/jiDDjtThPxGaGkjLMKFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Et031jdcLwAFRlz7TiUKS3/6hUFrwNXUxRqWhIbougR7n5RpbRb7FeVGdLBZwGx/TK
         N7nVIAOoYm2bvYFYy5z3c7kvvWpJsMGmKaNVgFEEWA/gVslGyXq8Cv4v1VZem1bnCXOv
         o6iI6GWudIE77/fmGSjw9JQb2ddiadQM6oAgY=
Received: by 10.204.81.31 with SMTP id v31mr4393109bkk.141.1275685416109; Fri, 
	04 Jun 2010 14:03:36 -0700 (PDT)
Received: by 10.204.18.207 with HTTP; Fri, 4 Jun 2010 14:03:36 -0700 (PDT)
In-Reply-To: <AANLkTin6tFu9vgRVGFa2nF6PL1PUE7Zmd0t5uenyCkEz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148438>

On Fri, Jun 4, 2010 at 2:44 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Jun 4, 2010 at 17:21, Dario Rodriguez <soft.d4rio@gmail.com> =
wrote:
>> Hmm... I will check makefiles today, but there is something wrong
>> here, take a look:
>>
>> $ INSTALL=3D$HOME/bin/install-sh /usr/linux/bin/make
>> prefix=3D$HOME/.gitbin NO_OPENSSL=3D1 NO_TCLTK=3D1 NO_EXPAT=3D1
>> PYTHON_PATH=3D/usr/local/bin/python install
>> =A0 =A0SUBDIR perl
>> =A0 =A0SUBDIR git_remote_helpers
>> Could not find platform dependent libraries <exec_prefix>
>> Consider setting $PYTHONHOME to <prefix>[:<exec_prefix>]
>> =A0 =A0SUBDIR templates
>> install -d -m 755 '/aplicaciones/D0/imei/usuarios/tximeid0/.gitbin/b=
in'
>> getopt: illegal option -- d
>> Usage: install [-c dira] [-f dirb] [-i] [-m] [-M mode] [-O owner]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [-G group] [-S] [-n dirc] [-o] [-s] file=
 [dirx ...]
>> make: *** [install] Error 2
>
> It's make INSTALL=3D.., not INSTALL=3D.. make
>

touch=E9! ... I will be testing it on AIX next Monday cause I have no
access to the server from home

Cheers,
Dario
