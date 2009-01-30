From: "Raimund Berger" <raimund.berger@gmail.com>
Subject: Re: Newbie question regarding 3way merge order.
Date: Fri, 30 Jan 2009 12:37:38 +0100
Message-ID: <87wscdaut9.fsf@gigli.quasi.internal>
References: <871vulda2r.fsf@gigli.quasi.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 12:39:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSriG-0007a6-6a
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 12:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbZA3Lhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 06:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbZA3Lhn
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 06:37:43 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:30584 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbZA3Lhm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 06:37:42 -0500
Received: by fg-out-1718.google.com with SMTP id d23so312796fga.27
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 03:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:references
         :mail-followup-to:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=LFSux7ZvS0Ju49NJstnvZFOqSZfUVQ9JiMxWkeccFGA=;
        b=TqOuecmwSd6iJlvVPDfplBboUamsksC1NvQJm0DR03FAyykpvtwoU7TR22EhZut4Cf
         RzO7ig73pVLzWWzQFRyk7cOVCYQDXh90RlAKK93Sa54zoeZExu/S5H7ZZezWAjKmwFZa
         prXzkD0gP9UgXjMHFQldjKWM0uHYjtGznTlTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:references:mail-followup-to:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=qnxhkl5m3ZDrd8sjfLAwbBspSla6ouND2z/J4QJ9gd+qSp/1Ge6Q1Nni/8tu1s2s55
         YFfgnwNhar9qZpf57lZHodn90v2vvx1UFLjD9Pe7S7fTlLxl6BFp1PWinL0NXsK6RBNg
         P1K2QoBwJtuDu5yMGCQI3Omi6wqoZhC6RfYS0=
Received: by 10.86.3.4 with SMTP id 4mr600527fgc.66.1233315461223;
        Fri, 30 Jan 2009 03:37:41 -0800 (PST)
Received: from gigli.quasi.internal (p5DC33F84.dip.t-dialin.net [93.195.63.132])
        by mx.google.com with ESMTPS id d4sm877879fga.41.2009.01.30.03.37.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jan 2009 03:37:40 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <871vulda2r.fsf@gigli.quasi.internal> (Raimund Berger's message
	of "Thu, 29 Jan 2009 23:25:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107800>


> The question is whether a (3way) merge is commutative, purely in terms
> of content 

Yes / No / Unknown ? 
