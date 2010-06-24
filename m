From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/9] Add memory pool library
Date: Thu, 24 Jun 2010 21:37:42 +0200
Message-ID: <AANLkTikNV0m5E7982wY5wdtcMstpfKKMX4MdZvdhqhOb@mail.gmail.com>
References: <20100624105004.GA12336@burratino> <20100624105339.GC12376@burratino> 
	<AANLkTilItX_xbbpX9mfKg0Dfx6ThzYuVsBu25C_-fJ6W@mail.gmail.com> 
	<20100624185521.GB1848@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 21:38:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORsFX-0007Mo-MG
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 21:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543Ab0FXTiH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 15:38:07 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46163 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab0FXTiE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 15:38:04 -0400
Received: by gye5 with SMTP id 5so4619886gye.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6KVy6OBxa7TzluDFqx74VTTk7slr0SSHlWuEVCe8gxk=;
        b=mt6fl6Rvpy2WD1yLpaYi2LP9UEeDeeQLUmJtwZ5yFNBAtdRxyTwIOBxkUyAkALghWR
         ig+PDbi6QJGPmyZIdt68eX9AA8FyfctjHd0iCbU7imJ7kZANbKJuJlFMSrLLGTGxadPg
         F3AOxo7EDhUi+iGTBw1laml0Q7akD5Cx6WZTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BKPSs4cCOkcZifffvXfI89P3bcX+r6hzy/qhuRxFddj4IHpAn44KdUHVutSYpe0VUo
         mY20e8H2Wxsdmt6wY65jLMxJbmtMhKNMRNAKBJw2HQhh+RvspOhBr18YyCyWtOH5dgjT
         bjeLSn5i/KVCfFKT/WMeEkk9NUd6gbR3JTtkE=
Received: by 10.229.249.139 with SMTP id mk11mr5601648qcb.101.1277408283700; 
	Thu, 24 Jun 2010 12:38:03 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Thu, 24 Jun 2010 12:37:42 -0700 (PDT)
In-Reply-To: <20100624185521.GB1848@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149628>

Hi Jonathan,

Jonathan Nieder wrote:
> If we used templates instead of macros, a smart compiler would notice
> which functions are _never_ used. =C2=A0But sticking to C, I think it=
 is
> fine to rely on humans checking by hand for now. =C2=A0(FWIW no obj_p=
ool
> functions are unused at the moment.)

> Filling out such a list for each caller sounds to me like more troubl=
e
> than it=E2=80=99s worth.

Okay, I have an idea. We'll document it as a comment so people will be
able to see which exact functions were unused in this import. The
following functions are unused: blob_init, blob_offset, blob_commit,
commit_free, commit_offset, dir_free, node_init, node_commit,
string_offset, tree_first, tree_next, tree_remove, log_init,
log_offset, and log_commit.

-- Ram
