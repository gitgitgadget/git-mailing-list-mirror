From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: ab/i18n (What's cooking in git.git (Feb 2011, #05; Wed, 23))
Date: Thu, 24 Feb 2011 10:56:11 +0100
Message-ID: <AANLkTimn_CmWORwJfWXEiY18QCmXdNZMhCUC9YBMo_kV@mail.gmail.com>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org> <20110223234828.GA7286@elie>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 10:58:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsXyF-00089M-QQ
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 10:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282Ab1BXJ6r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 04:58:47 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37009 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172Ab1BXJ6q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 04:58:46 -0500
Received: by fxm17 with SMTP id 17so360976fxm.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 01:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9ZkHRH0gzuIug76iRG9g2gFZmXjA4iZbq6uI/X2v2Nw=;
        b=oWftM/7GO51EpuZsGT6tdU1MVwIEjxNy4OvqBRmW+zI1OUkl16rl6VjHVh4/UdtV38
         36xDqZUm6kr/+gcwudBF6wHzaU0KQlRXp1ZVUQTId1joQEXfjLPC+8oUFdB+blDTDY/P
         E6SJN2E4mYzPMbeoLQ0GKQvGJ9zTeMNdH9fhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=HKonXIAA++VshSaF05oGAnQCQYYHtF6eDAlzPRr+f9GBlcJaXsHdvdGdW4HJjod6iI
         kB9XOFTK7XH9viV0zNwcKmoUKaJtAW7YUErwXn9brzhI+zXLOa6S448Ww3fi4B6fBMom
         vcvPK0CAt9rEPfx5EQgJlY3zytG5N9m5MJXLY=
Received: by 10.223.101.134 with SMTP id c6mr764812fao.12.1298541392149; Thu,
 24 Feb 2011 01:56:32 -0800 (PST)
Received: by 10.223.95.206 with HTTP; Thu, 24 Feb 2011 01:56:11 -0800 (PST)
In-Reply-To: <20110223234828.GA7286@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167789>

On Thu, Feb 24, 2011 at 12:48 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> There is also a patch out there to make this use rot13, which I am
> somewhat fond of. =A0Unfortunately, it leaks (because it is not clear
> how long translated strings are supposed to last).
>

I like the idea, but perhaps we could auto-generate a Pig Latin
translation or something instead? Pig Latin has the benefit over
rot-13 of the strings being of a different length than the original,
which might trigger some bugs that same-length translations might
not...
