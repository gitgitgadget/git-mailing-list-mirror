From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Tue, 10 Feb 2009 19:42:32 +0100
Message-ID: <2c6b72b30902101042o64a1a490ge18af497faa747c5@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk>
	 <20090209220750.GA27232@m62s10.vlinux.de>
	 <20090209222236.GA4166@coredump.intra.peff.net>
	 <20090209223044.GB27232@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 19:44:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWxaV-00058B-1o
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 19:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbZBJSmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 13:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbZBJSmg
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 13:42:36 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:39185 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802AbZBJSmf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 13:42:35 -0500
Received: by bwz5 with SMTP id 5so3038614bwz.13
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 10:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=lcyNAM9nK/UnrbFBHtIKixTehYdbduWMxSkM54sNAnE=;
        b=v+juFNwB5VjdVi+vXF1vMK1PoPzvMV0Wlf03/+fbuT1vsEqF7Bn9wqmb3Z17z/tnmT
         y/MOiCZG1VFY8HRIopjPbeqjHmuoTMA2heSo6awG2XonScLugtwEySoZm0Uwboq+i4b4
         /EYTuEvyWsWPtPl2tIbAsHvLGjuc3IOvECoCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=HNmYF3CMvNfl45IDXZRlDinbErPmHM4D6lrksFVMqqJc2183PuPuo+IYqXUXGKL79J
         XM0Ie8kzIQJN3KsvbSLkYeNa+Wj3J5FV3IOA/KvWSiUC2j8QOhpvM/IWUlbwWb4gbz0j
         xiX/RsOVwzDz300SSt+t288j5xn9J2MBd8RQ0=
Received: by 10.181.239.8 with SMTP id q8mr1684157bkr.1.1234291352651; Tue, 10 
	Feb 2009 10:42:32 -0800 (PST)
In-Reply-To: <20090209223044.GB27232@m62s10.vlinux.de>
X-Google-Sender-Auth: da973e8c59994c57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109290>

On Mon, Feb 9, 2009 at 23:30, Peter Baumann <waste.manager@gmx.de> wrote:
> On Mon, Feb 09, 2009 at 05:22:36PM -0500, Jeff King wrote:
>> Don't the up and down arrows switch the commit (updating the diff pane
>> as appropriate), and PgUp/PgDown scroll the diff window (I don't know
>> the actual function names, but you should be able to even rebind these
>> in your tigrc if you want).
>
> Damn. I'm so used to the vi keybindings pressing j/k to move down/up
> that I didn't check the cursor keys.

Well, initially tig worked similar to what you expected and a program
like slrn, where up/down (or j/k) moves between articles (commits) and
you have to press enter to actually show/load the commit in the diff
view. This mode might be more natural, and Jari has argued that it
would make tig (and it's many forks) more bearable to on Cygwin
running on an old PC.

Anyway, I would like to add support for something like this in the
future. But it will require some restructuring of the code to make the
link between the main view and it's diff view more natural.

-- 
Jonas Fonseca
