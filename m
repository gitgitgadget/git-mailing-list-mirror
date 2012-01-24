From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] add a Makefile switch to avoid gettext translation in
 shell scripts
Date: Tue, 24 Jan 2012 20:59:19 +0100
Message-ID: <CALxABCZ0j-Pb9d9GTvkcWjmsWpmy+bUmwMWkwUTEzui5Oir_BQ@mail.gmail.com>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <CALxABCbaBmP6k5TYrYLCYm8oiv=9cF=N7_opSTKUnbkz5b-cwg@mail.gmail.com>
 <20120119195222.GA5011@blimp.dmz> <7v1uqq84es.fsf@alter.siamese.dyndns.org>
 <7vwr8i6prk.fsf_-_@alter.siamese.dyndns.org> <7vr4yq6poy.fsf_-_@alter.siamese.dyndns.org>
 <20120123221256.GG20833@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 20:59:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpmWv-0003vS-70
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 20:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917Ab2AXT7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 14:59:40 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:65195 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753321Ab2AXT7k (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jan 2012 14:59:40 -0500
Received: by obcva7 with SMTP id va7so4681932obc.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 11:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PTnO9Eqk8eI4KApfDC4XpdHjUmF6I2VK20OH7fjD8jQ=;
        b=ttrUT0P/pjpYTtC+9Yjh3haKU0SOzjnW9V2DrWXtH/gBJNuodlAYvk58nrWsTVRmDI
         FNK7bz+nhXR6tLGwbvIcVB0QcRg7wRlJExDmIBD44zw7R/WYwICy+z86mW70QbmKMFgI
         OATcSIPlLCTJF57jKNQoXK20e2A8hFU36gJNs=
Received: by 10.182.117.8 with SMTP id ka8mr12910993obb.73.1327435179180; Tue,
 24 Jan 2012 11:59:39 -0800 (PST)
Received: by 10.182.226.41 with HTTP; Tue, 24 Jan 2012 11:59:19 -0800 (PST)
In-Reply-To: <20120123221256.GG20833@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189060>

On Mon, Jan 23, 2012 at 23:12, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Here's a patch to consider squashing in that makes the option take
> effect if it changes between builds.

Which actually bit me once, when I was playing with the code :)
