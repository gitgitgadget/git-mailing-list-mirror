From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v3 1/2] Factor find_pack_entry()'s core out
Date: Wed, 01 Feb 2012 18:37:17 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1202011836560.2759@xanadu.home>
References: <1328010239-29669-1-git-send-email-pclouds@gmail.com>
 <1328104135-475-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.02.1202011056140.2759@xanadu.home>
 <7vaa522oum.fsf@alter.siamese.dyndns.org>
 <7v1uqe2ngh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 00:37:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsjjy-0008U6-4f
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 00:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038Ab2BAXhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 18:37:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62760 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab2BAXhS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 18:37:18 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LYQ00AUTMY0K5C0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 01 Feb 2012 18:37:12 -0500 (EST)
In-reply-to: <7v1uqe2ngh.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189556>

On Wed, 1 Feb 2012, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Nicolas Pitre <nico@fluxnic.net> writes:
> >
> >>> +static int find_pack_entry_1(const unsigned char *sha1,
> >>> +			     struct packed_git *p, struct pack_entry *e)
> >>
> >> This looks all goot but the name.  Pretty please, try to find something 
> >> that is more descriptive than "1".  Suggestions: 
> >> "find_pack_entry_lookup", "find_pack_entry_inner", etc.
> >
> > Perhaps "find_pack_entry_in_pack(sha1, e, p)"?
> > That would go well with the caller "find_pack_entry(sha1, e)".
> 
> I amended 1/2 (and adjusted 2/2 to match) to call it fill_pack_entry.
> Will push out the result tonight.

Looks fine to me.


Nicolas
