From: Geert Bosch <bosch@adacore.com>
Subject: Re: Features from GitSurvey 2010
Date: Thu, 3 Feb 2011 09:38:27 -0500
Message-ID: <FE2BDD68-9CFA-4CBB-9F66-32BE6CF3E174@adacore.com>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com> <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com> <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com> <AANLkTi=_DPSp2P3MuFOPgua2nH7U+RUt4AfAHSyPVv-G@mail.gmail.com> <AANLkTi=KUpYJBRMp9ti0h+g6a0iTw4D113rTgfTpR8C4@mail.gmail.com> <alpine.LFD.2.00.1102011647000.8580@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 15:49:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl0UV-0003hs-Jj
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 15:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945Ab1BCOsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 09:48:36 -0500
Received: from rock.gnat.com ([205.232.38.15]:48381 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755883Ab1BCOse (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 09:48:34 -0500
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Feb 2011 09:48:34 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id D4A4C2BACAC;
	Thu,  3 Feb 2011 09:38:27 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id H4XGNCzzNNwq; Thu,  3 Feb 2011 09:38:27 -0500 (EST)
Received: from potomac.gnat.com (potomac.gnat.com [205.232.38.115])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id C08452BACA8;
	Thu,  3 Feb 2011 09:38:27 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1102011647000.8580@xanadu.home>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165974>


On Feb 1, 2011, at 16:51, Nicolas Pitre wrote:

> Also... people interested in Narrow clones are likely to be shallow 
> clone users too, right?

Not necessarily. Many corporate repositories are huge (caused by
the concept of 1 central repository with everything in it) and have
tons of crud (like marketing materials, media-heavy powerpoint
presentations).  Here you really want a narrow clone (such as the
sources of the project you're working on), but don't mind having
the whole history.

Looking at it from another angle: typically the whole history of a
project is not much bigger than a check out, so it is fine to have
a deep history. On the other hand, for these monster repositories
one would typically do a narrow clone of only a single subdirectory
that may be more than an order of magnitude smaller.

These narrow clones are especially important for imports of unwieldy
svn repositories where there is a large amount of unstructured
branching.

Regards,
   -Geert
