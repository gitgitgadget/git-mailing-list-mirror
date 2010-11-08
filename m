From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: Add "First parent" checkbox
Date: Mon, 8 Nov 2010 15:11:01 -0600
Message-ID: <20101108211101.GA13114@burratino>
References: <20101108194817.GC6348@burratino>
 <1jrnp0m.116vp4ycag4blM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Mon Nov 08 22:11:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFYzt-0000eE-Qf
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 22:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab0KHVLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 16:11:19 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48300 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755554Ab0KHVLR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 16:11:17 -0500
Received: by iwn10 with SMTP id 10so314222iwn.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 13:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=YKd8oXLWyx1pvH3ZtGE5I61pAMGg8aXhJ2ZUFyLxmeg=;
        b=mwJRrCGmoNc7SbEXu07OcaLbAJt0uY583aiJzPHd+KeWZKndSeIzsr2F3JztBP8jKK
         MEfPAmz16FR0nSe9Z2HSD34T4XVvyQpgL8v73BsiwYCqi8v8haQWz2RTjLzwy4MZ8BGy
         lvpKRQHzRX28pUAtFV3oxGTuivWz8sVfNi6hA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=N1IxuJJuiMcqtg/0ots4FD9yEGAtO+MaC/1ZGwdKbAThNmQC69TebCfxUAVm2k6SXo
         SW1ae9m6yI9f5NJj/KzLiyNf0wMNEBDskoL89IPtK+Bd0GtRDcF9c1rcwkZ8Lu4PIsft
         yfi3seP6NcsqdR1R4jrxzOQvyxNZAD4RyYlBY=
Received: by 10.231.35.203 with SMTP id q11mr4407850ibd.197.1289250677254;
        Mon, 08 Nov 2010 13:11:17 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id fw4sm309466ibb.19.2010.11.08.13.11.15
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 13:11:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1jrnp0m.116vp4ycag4blM%lists@haller-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160990>

Stefan Haller wrote:

>                                   Most of the diff related options are
> ones that I want to toggle with one click.  That's certainly true for
> "Ignore space change", "First parent", and the "Diff/Old Version/New
> Version" radio buttons.  I would hate to see any of them be removed from
> the diff pane.

Thanks, that's useful information.  Could you give example workflows
to illustrate this?  Here's an example:

   Toggling between "Diff/Old version/New version" with a single click
   allows one to compare the preimage and postimage of a patch visually.
   It makes what changed much more obvious.

   Historically these have been radio buttons on the top-left part of
   the diff pane.  If they move, it might be hard for people already
   familiar with gitk to find them.

   The preimage/postimage toggle is a useful and novel feature, and it
   is greedy with respect to screen real estate (a few extra diff
   lines can go a long way), so it would not be good to hide it in a
   separate "more diff options" toolbar.

The case for one-click "diff against parent" is less clear.  Is it
that it gets toggled in practice often (i.e., avoiding pointless
repetitive actions)?

Hope that helps.
