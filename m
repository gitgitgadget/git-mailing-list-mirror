From: Steven Grimm <koreth@midwinter.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 19:49:12 -0700
Message-ID: <46DF6AA8.60804@midwinter.com>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix> <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix> <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org> <20070906024555.GJ18160@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Nix <nix@esperi.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 04:49:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT7Qk-0002hi-Dk
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 04:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbXIFCtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 22:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757473AbXIFCtO
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 22:49:14 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:60107 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1757457AbXIFCtN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 22:49:13 -0400
Received: (qmail 24553 invoked from network); 6 Sep 2007 02:49:12 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=mkNDo1LcNks//MRQxoLJrTT1cZT+SyWs1HUAneubdeDcQLA5iCPTZ/imcKRMfj1r  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 6 Sep 2007 02:49:12 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <20070906024555.GJ18160@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57807>

Shawn O. Pearce wrote:
> But this suffers from the same fate if the user sets gc.auto too
> small and doesn't realize that the reason Git is always repacking
> is because over the last 6 months they have been unlucky enough to
> stage the magic number of unreachable blobs into the 17 directory
> and they have *never* run `git gc --prune` because the auto thing
> is working just fine for them and they don't realize they need to
> prune every once in a blue moon.
>   

Check the modification times on those files and don't count ones that 
are older than the last git-gc run, maybe? That'd take care of the problem.

-Steve
