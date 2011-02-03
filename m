From: Geert Bosch <bosch@adacore.com>
Subject: Re: Narrow clone (Re: features from GitSurvey 2010)
Date: Thu, 3 Feb 2011 16:23:57 -0500
Message-ID: <5E0364BF-35CD-4797-BBAF-98A54D1F7F6E@adacore.com>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com> <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com> <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com> <AANLkTi=_DPSp2P3MuFOPgua2nH7U+RUt4AfAHSyPVv-G@mail.gmail.com> <AANLkTi=KUpYJBRMp9ti0h+g6a0iTw4D113rTgfTpR8C4@mail.gmail.com> <alpine.LFD.2.00.1102011647000.8580@xanadu.home> <FE2BDD68-9CFA-4CBB-9F66-32BE6CF3E174@adacore.com> <20110203173835.GC30341@elie>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 22:24:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl6er-0003Vt-Jp
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 22:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320Ab1BCVYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 16:24:00 -0500
Received: from rock.gnat.com ([205.232.38.15]:36560 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130Ab1BCVX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 16:23:59 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 8474E2BAB04;
	Thu,  3 Feb 2011 16:23:58 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id u8I2qf7qjJrN; Thu,  3 Feb 2011 16:23:58 -0500 (EST)
Received: from potomac.gnat.com (potomac.gnat.com [205.232.38.115])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id 6E1A92BAAFA;
	Thu,  3 Feb 2011 16:23:58 -0500 (EST)
In-Reply-To: <20110203173835.GC30341@elie>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165999>


On Feb 3, 2011, at 12:39, Jonathan Nieder wrote:

> Geert Bosch wrote:
> 
>> These narrow clones are especially important for imports of unwieldy
>> svn repositories where there is a large amount of unstructured
>> branching.
> 
> Wouldn't a more careful import be a better solution to that problem?

Yes.

> Practically speaking, I'd rather work with an enormous svn repo like
> that by using git-svn to extract subsets than with a botched import
> that treats it as one huge (git-managed) project.

Practically speaking, I don't always have a say in the organization
of repositories that I have to work with. Some would rather
spend 30+ days of CPU time to import an entire SVN repository with
branch forests straight into git than considering organization.
Of course the resulting git repository will be less than useful.
And that's where the narrow clone comes in handy...

  -Geert
