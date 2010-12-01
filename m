From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] Documentation/config.txt: Order variables
 alphabetically
Date: Wed, 1 Dec 2010 10:13:11 -0600
Message-ID: <20101201161311.GC26120@burratino>
References: <87eia1wo5v.fsf@picasso.cante.net>
 <31def5a4a6256e6fdef8a03372cda98460f61c47.1291217124.git.jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: jari.aalto@cante.net
X-From: git-owner@vger.kernel.org Wed Dec 01 17:13:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNpJ9-0001Fs-GZ
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 17:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263Ab0LAQNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 11:13:21 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52115 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab0LAQNU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 11:13:20 -0500
Received: by vws16 with SMTP id 16so392995vws.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 08:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Aik9neeQP65I3/4BT/Pu8a/YFxTun7wwb5+gJ95n4zQ=;
        b=pN3YefjunHWyIoappWqudbkRDGaf2Ozig20HjI9ocpb7OuKoWOmx3o0RH7ag5SjWsz
         EUHBlhtka5+sZrwrxOqsor3guzlFUrv9bqnFfT48LJGpsJ/Qy89F+aJtJAJ1LnhqjV0A
         cGqDlBzdw5rIrj/ZqQ9vCE8VB+OLAKshoOUcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=l1bzW6g1lNUciGbdrJK4fs590s1SLt2tvx3n47NRe7sMqMHMLqxt9vgIrMunDykOMr
         Tkliip7/Rq8Og2n+13pUK5S4eauuX+yaSvylL0DFwGnUKrlc06AKCJG4102jiQfSECZ0
         QXi+lsjHTYEk/Jb7EaIdzVw9V5aHqroPbUTug=
Received: by 10.220.86.149 with SMTP id s21mr2065647vcl.27.1291219999404;
        Wed, 01 Dec 2010 08:13:19 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id l14sm37116vcr.18.2010.12.01.08.13.17
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 08:13:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <31def5a4a6256e6fdef8a03372cda98460f61c47.1291217124.git.jari.aalto@cante.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162542>

Hi,

jari.aalto@cante.net wrote:

> From: Jari Aalto <jari.aalto@cante.net>

Could you or some other interested person give a diff of just the
lines with ::, as well as confirming that the other lines did not
change, only shuffled around?  It would be nice to get a sense of the
net effect of the change.

Regardless of the answer, it needs justification _in the log message_.
Putting this in alphabetical order may make it easier for people to
decide where to add their future config variables, but they will
wonder why that order, and whether it is worth changing again.

FWIW the "my man pager is broken" justification doesn't seem so strong
to me.  The "my hardcopy of the manual doesn't have an easy search
function" seems more compelling, except that there is work in progress
to fix that by splitting documentation of config vars by affected
command and making gitconfig(5) proper into an index.

Hope that helps,
Jonathan
