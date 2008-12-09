From: Grzegorz Kossakowski <grek@tuffmail.com>
Subject: Re: How to clone git repository with git-svn meta-data included?
Date: Tue, 09 Dec 2008 21:57:06 +0100
Message-ID: <493EDBA2.3070404@tuffmail.com>
References: <493A6CEC.4060601@tuffmail.com>	 <eaa105840812070857i27f8e920keaba3f92f5260b38@mail.gmail.com>	 <493C1F36.7050504@tuffmail.com>	 <eaa105840812071230l5e8d54bcg21b36019711bc3cd@mail.gmail.com>	 <493C47FD.4080302@tuffmail.com>	 <493D1CC2.8050407@drmicha.warpmail.net>	 <493D66BB.3060907@tuffmail.com>	 <eaa105840812081040s1036b79an9914c1f74d6d7f6a@mail.gmail.com>	 <493D6AE9.6020504@tuffmail.com> <1228813734.28186.77.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
To: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 21:58:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA9f7-0001Sf-Ty
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 21:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbYLIU5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 15:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753826AbYLIU5K
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 15:57:10 -0500
Received: from mxout-03.mxes.net ([216.86.168.178]:4676 "EHLO
	mxout-03.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462AbYLIU5J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 15:57:09 -0500
Received: from [192.168.0.125] (unknown [82.210.157.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTP id A9DB623E4A9;
	Tue,  9 Dec 2008 15:57:07 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081112)
In-Reply-To: <1228813734.28186.77.camel@maia.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102654>

Sam Vilain pisze:
> It's up to the git-svn user to make sure that they prepare the refs to
> be what git-svn expects.  This is something probably requiring more
> documentation and/or git-svn features to be easier.

What I was asking if we should add trunk ref to svn mirror so others cloning it will have
'origin/trunk' reference created automatically during clone process so no extra steps would be needed.

To be honest, I don't understand how Git exactly handles all this refs mapping and rewriting (e.g.
during cloning). Having said that, I cannot foresee all possible implications of choosing particular
method of solving current issues thus asking you.

>> Would it be the best practice?
> 
> Well, obscure stuff should never really be best practice.  The best practice
> is to have a single git repository that is where the svn -> git migration
> happens.  And git-svn could perhaps auto-init based on information in the
> commit log or something.  Best practice is to enhance the tool to work the
> way it Should(tm) :)

Cannot follow you here. We want single svn mirror but at the same time we want to our committers to
be able to push back to svn. What has been already proposed satisfies my need apart from the fact
that currently there is  small problem with our mirror setup.

-- 
Best regards,
Grzegorz Kossakowski
