From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Narrow clone (Re: features from GitSurvey 2010)
Date: Thu, 3 Feb 2011 11:39:09 -0600
Message-ID: <20110203173835.GC30341@elie>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino>
 <201102011451.17456.jnareb@gmail.com>
 <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com>
 <AANLkTi=_DPSp2P3MuFOPgua2nH7U+RUt4AfAHSyPVv-G@mail.gmail.com>
 <AANLkTi=KUpYJBRMp9ti0h+g6a0iTw4D113rTgfTpR8C4@mail.gmail.com>
 <alpine.LFD.2.00.1102011647000.8580@xanadu.home>
 <FE2BDD68-9CFA-4CBB-9F66-32BE6CF3E174@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 18:39:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl39e-0002Se-Jr
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 18:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756663Ab1BCRjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 12:39:24 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48910 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441Ab1BCRjX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 12:39:23 -0500
Received: by fxm20 with SMTP id 20so1456890fxm.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 09:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=CJhHFrAIV5IPbjMnKO8l0ikOmruYAyfhIwswuj14sBk=;
        b=J8PkQC3zF9OkKgb1UGEZgGS5Uj1w1QdJIzEXRTar9aRDtOkMKfH9LmcevqtDwJOOwt
         02AiJmccBQZd1YlpYdeBgWZPJcBg6ZKDLkLEup5zxkNCZLjE3sU2TtB1nOAiSyBpZ2Yn
         PxenqB/3i6P3kS8aCDbPov3kaooEhA2UxGvFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dRxQnOLR8Osqo/4d4CTHFHm5oewuoi3jAP1Z8dUvGABtaqpwGnxwk6NazDhk0YaYUQ
         wdDgqCS1xCgEDaH2emhzaEtV7OVfm/q5xDzROSiIN4Ge8ZN/ihIQQkq3kmpM6QUHh90n
         eucptxNfket4rahmSjELExzbIKIsEQtSznEQM=
Received: by 10.223.98.200 with SMTP id r8mr3045745fan.30.1296754762280;
        Thu, 03 Feb 2011 09:39:22 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id 5sm392993fak.47.2011.02.03.09.39.13
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Feb 2011 09:39:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <FE2BDD68-9CFA-4CBB-9F66-32BE6CF3E174@adacore.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165985>

Geert Bosch wrote:

> These narrow clones are especially important for imports of unwieldy
> svn repositories where there is a large amount of unstructured
> branching.

Wouldn't a more careful import be a better solution to that problem?
Practically speaking, I'd rather work with an enormous svn repo like
that by using git-svn to extract subsets than with a botched import
that treats it as one huge (git-managed) project.

svn-all-fast-import, for example, has a fairly simple configuration
syntax allowing to extract whatever subrepositories are needed.
