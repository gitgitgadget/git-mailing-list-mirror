From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Wed, 15 Apr 2009 13:09:43 +1000
Message-ID: <fcaeb9bf0904142009w5a21e483v7e98f91e5e35b14a@mail.gmail.com>
References: <alpine.LFD.2.00.0904070903020.6741@xanadu.home> 
	<alpine.LFD.2.00.0904071321520.6741@xanadu.home> <20090407181259.GB4413@atjola.homenet> 
	<alpine.LFD.2.00.0904071454250.6741@xanadu.home> <20090407202725.GC4413@atjola.homenet> 
	<alpine.LFD.2.00.0904080041240.6741@xanadu.home> <20090410T203405Z@curie.orbis-terrarum.net> 
	<alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904141542161.6741@xanadu.home> 
	<20090414T202206Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 05:11:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtvXH-0006wA-Bj
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 05:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010AbZDODKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 23:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753660AbZDODKE
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 23:10:04 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:31454 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbZDODKC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 23:10:02 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2898421rvb.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 20:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=RASXPtXOhWvyaSg2X2MPNmMyOK982jO7aJt1uW4eASk=;
        b=gVQoITsNL+IUQ2FXMg3x9rC/ZqHu+qCMok4bB37xV7VNNLgL9tEHIFVZBzN0FEGPOF
         jpk3h6/MUh7pCd3G+Hr5AAww1zD1Be2O8qZ3TO1bn4rgBg93/bNoQr1x7u7JbyhfnwHk
         4IrPj4qoW8FRDmEphqS2D8mDNU6SiuraKM9Xc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=I9OS8CpE9K9UN68whPIII7RjUrMpU1UYXjv2x7BweH1YU3pr4WsuW7XHcNIOQ7NnFh
         wZw7aDRlw0fPel0/gWUbAFao/BmuLA1ofEwidEVB+B+DxYKxYz2B16IV2LAjFY3QekpH
         hw4Vy89iQxUyW2BvuILoN6gXstNuXOf7cK0/4=
Received: by 10.142.51.4 with SMTP id y4mr4063959wfy.39.1239764998071; Tue, 14 
	Apr 2009 20:09:58 -0700 (PDT)
In-Reply-To: <20090414T202206Z@curie.orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116586>

On Wed, Apr 15, 2009 at 6:27 AM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> So, from the Gentoo side right now, we're looking at this:
> 1. Setup git-bundle for initial downloads.
> 2. Disallow initial clones over git:// (allow updates ONLY)

How can you do that? If I understand git protocol correctly, there is
no difference between a fetch request and a clone one.

> 3. Disallow git-over-http, git-over-rsync.
-- 
Duy
