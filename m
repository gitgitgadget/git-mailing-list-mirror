From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [BUG PATCH RFC] mailinfo: correctly handle multiline 'Subject:' header
Date: Wed, 14 Jan 2009 11:19:42 +0300
Organization: St.Petersburg State University
Message-ID: <20090114081942.GA6399@landau.phys.spbu.ru>
References: <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org> <7vy6xm42l3.fsf@gitster.siamese.dyndns.org> <1230316721-14339-1-git-send-email-kirr@mns.spb.ru> <20090107224342.GB4946@roro3> <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org> <20090108231135.GB4185@roro3> <7veizatxo9.fsf@gitster.siamese.dyndns.org> <20090112223447.GA5948@roro3.zxlink> <7v63kkgl5b.fsf@gitster.siamese.dyndns.org> <20090113093916.GA25471@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Potashev <aspotashev@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 09:21:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN102-0003RH-DP
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 09:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbZANITp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 03:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbZANITp
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 03:19:45 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:1829 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbZANITo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 03:19:44 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 50BE817B661; Wed, 14 Jan 2009 11:19:42 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <20090113093916.GA25471@landau.phys.spbu.ru>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105600>

On Tue, Jan 13, 2009 at 12:39:16PM +0300, Kirill Smelkov wrote:
> On Mon, Jan 12, 2009 at 03:27:44PM -0800, Junio C Hamano wrote:
> > Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

[...]

> > But doesn't this
> > 
> > >  From nobody Mon Sep 17 00:00:00 2001
> > > -From: A
> > > +From: A (zzz)
> > >        U
> > >        Thor
> > > -      <a.u.thor@example.com>
> > > +      <a.u.thor@example.com> (Comment)
> > 
> > regress for people who spell their names like this?
> > 
> > 	From: john.doe@email.xz (John Doe)
> 
> I think everything is ok:
[...]

Just in case it got spam-detected again:

http://marc.info/?l=git&m=123183962105146&w=2


Thanks,
Kirill
