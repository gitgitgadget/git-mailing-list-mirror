From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git and securing a repository
Date: Thu, 3 Jan 2008 10:11:24 +0100
Message-ID: <200801031011.29050.jnareb@gmail.com>
References: <477B39B5.5010107@advancedsl.com.ar> <m3ir2co5s4.fsf@roke.D-201> <20080103035838.GA24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 03 10:12:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAM7W-00072Q-UD
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 10:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbYACJLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 04:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbYACJLn
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 04:11:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:16498 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbYACJLm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 04:11:42 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2625259ugc.16
        for <git@vger.kernel.org>; Thu, 03 Jan 2008 01:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=p+ojJrFjo3ERcRGAvrkx3gxQoN39mniy31IBjlisnCg=;
        b=CuKB8/o4rq66sC4/059HP/0MeIwPCOeoxGWsgRrIaGsjaXkblLcLS6bn9AR4g8EVHn1N3tldlZGW/dCajdRIbgT4l87nIVXhcQ/sxo8GAJExVByZaXfBuJpc/HLNCg4CDSuOGeGQaUvL+9YJ3nGUGzhlJaRquClfgKdfvx57CWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VPANQuKyMz5Q0OGSjYmpZ+0pAlsCj2QoXX4L97EXe0Soe0QSnIYp912PEkN9g8l0hZMZeEw3fJsfZva9z2sgD2kvvRtm/a4iSDCkLpP+YElqlApq0HcI7Pv8cAexFHfrUqqHpdHpm0GUkjhMhVdfzUcZPJkrkmGq6u7TAbzF8gg=
Received: by 10.66.243.4 with SMTP id q4mr14995912ugh.5.1199351500994;
        Thu, 03 Jan 2008 01:11:40 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.227.171])
        by mx.google.com with ESMTPS id y37sm23798934iky.7.2008.01.03.01.11.38
        (version=SSLv3 cipher=OTHER);
        Thu, 03 Jan 2008 01:11:39 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080103035838.GA24004@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69518>

Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
  
> > AFAIK both update and pre-receive hooks are invoked also on fetch...
> > but I might be mistaken.
> 
> No, they are *not* invoked on fetch.  Currently no hooks execute
> during fetch; either on the server *or* on the client side of
> the connection.

Errr... I think at least post-update hook (the one with 
git-update-server-info by default) is invoked on fetch.

-- 
Jakub Narebski
Poland
