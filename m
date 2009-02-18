From: Kris Shannon <kris@shannon.id.au>
Subject: Re: [PATCH] Make tig call the correct git config command
Date: Wed, 18 Feb 2009 22:12:27 +1100
Message-ID: <e51f4f550902180312y3e1999e8x5ff119516cd9bbae@mail.gmail.com>
References: <237967ef0902072346x4537f70dua37ba897fac99361@mail.gmail.com>
	 <237967ef0902072349t784e1519m3561ef02545a72de@mail.gmail.com>
	 <2c6b72b30902080156u3b8ba41m736bffaa7b6f15e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Feb 18 12:14:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZkNJ-0005WH-Eu
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 12:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbZBRLM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 06:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbZBRLM3
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 06:12:29 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:10131 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbZBRLM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 06:12:28 -0500
Received: by wf-out-1314.google.com with SMTP id 28so3808542wfa.4
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 03:12:27 -0800 (PST)
Received: by 10.142.90.16 with SMTP id n16mr2738317wfb.314.1234955547444; Wed, 
	18 Feb 2009 03:12:27 -0800 (PST)
In-Reply-To: <2c6b72b30902080156u3b8ba41m736bffaa7b6f15e9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110526>

2009/2/8 Jonas Fonseca <fonseca@diku.dk>
> I wonder if this check in configure should not be removed anyway,
> since it is starting to be a long time since git-repo-config was
> renamed.

Speaking from a packaging standpoint,  as this is the only reason
git-core is a build dependency I would vote to get rid of it.

(I currently already patch the configure so I can build without git-core
installed)
