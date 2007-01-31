From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: Why is git clone not checking out files?
Date: Wed, 31 Jan 2007 10:56:53 +0100
Message-ID: <8fe92b430701310156u958f6dau31552c636ba6bce2@mail.gmail.com>
References: <17855.35058.967318.546726@lisa.zopyra.com>
	 <17855.36470.309129.391271@lisa.zopyra.com>
	 <Pine.LNX.4.64.0701301040200.3611@woody.linux-foundation.org>
	 <200701301950.00195.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Bill Lear" <rael@zopyra.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 10:57:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCCD5-0007K9-DC
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 10:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932922AbXAaJ44 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 04:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932923AbXAaJ44
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 04:56:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:44234 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932922AbXAaJ4z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 04:56:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so124522uga
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 01:56:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r0WUvpxQ9DjdzFRuJhGazYe4ncQ5gg7FhMvNSIl/GeETA9aO1ZkmEbES6s15NrDHDdKwX/yMlFNtXnu2g6/wARaJ1qAwMyCUZ+wkk23qK1D8eW/U7Putq41u3WIbGahWnPClcKZMCIyu9rBf64mD+x4qdpXkMxuxx18gxWQecUo=
Received: by 10.78.158.11 with SMTP id g11mr114328hue.1170237413617;
        Wed, 31 Jan 2007 01:56:53 -0800 (PST)
Received: by 10.78.161.4 with HTTP; Wed, 31 Jan 2007 01:56:53 -0800 (PST)
In-Reply-To: <200701301950.00195.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38237>

On 1/30/07, Jakub Narebski <jnareb@gmail.com> wrote:

> ...so "git clone" tries to checkout HEAD -> refs/heads/master
> branch, which does not exist. It is strange that git does not
> report error or at least warning, though...

It would be nice if git-clone at the very end (at checkout) wrote which
branch we are at, e.g.
  "On branch refs/heads/master"
  "Not currently on any branch"
  "Current branch refs/heads/master does not exist"
-- 
Jakub Narebski
