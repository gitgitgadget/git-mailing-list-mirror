From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: local configuration
Date: Mon, 20 Jul 2009 13:47:57 +0200
Message-ID: <20090720114757.GA25657@vidovic>
References: <33BF73EE-79AB-435F-B35F-E848DD1F3BF3@roalddevries.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roald de Vries <rdv@roalddevries.nl>
X-From: git-owner@vger.kernel.org Mon Jul 20 13:48:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSrLn-00007B-0N
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 13:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbZGTLsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 07:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbZGTLsD
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 07:48:03 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:51853 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbZGTLsB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 07:48:01 -0400
Received: by ewy26 with SMTP id 26so2201405ewy.37
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 04:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=sERNwvtSRPmG0gd9f+tvUOYSOWUBlN3Lb8l5WORKrVw=;
        b=NP9uevG3A1vCQPC4yNHMbjkP/4ty+O1WbXeRZZlxDcsEhiCLof8daqP9faTgAxVCvf
         Iu8ZRYkO01qP1k5aSHWuI5/Q4JSLA1DqFvkcCfdpIIbV3OTNAMn1dx7gyGvztXYZQlQ0
         iDVQ8VH24cW7pVYeCdgS8YPwHxREK0cIu+h0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Pwk0K8juSTFQEC7/xSP67Joey1SGGHpvms2SI3Y+G8swM3FAlWEidAWE9l5ZuK3cUI
         42aODtmvGZqL5W0S7LQogWUSvwOWjiIklo2ntneMeC/xsRoJLnFM3voXqOHL32bbqqR1
         BuDcgx2Nu6MAzYr3Zcn/ysqiNOpVCdF5bTdoU=
Received: by 10.210.110.2 with SMTP id i2mr3547850ebc.31.1248090480385;
        Mon, 20 Jul 2009 04:48:00 -0700 (PDT)
Received: from @ (91-164-133-76.rev.libertysurf.net [91.164.133.76])
        by mx.google.com with ESMTPS id 10sm858178eyd.49.2009.07.20.04.47.59
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Jul 2009 04:47:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <33BF73EE-79AB-435F-B35F-E848DD1F3BF3@roalddevries.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123588>

The 20/07/09, Roald de Vries wrote:

> I want to use git to synchronize my bashrc's (and other configuration  
> files) between computers. These have common stuff in them, and stuff  
> that's specific to a certain computer. The way I do it now is with a  
> branch for each computer, and one common branch. Is this a known use  
> case, am I misusing git, and is there a more elegant way to do this?

I try to write my conf files as portable as possible. Today, I don't
need dedicated branches but that's the way I would achieve it.

-- 
Nicolas Sebrecht
