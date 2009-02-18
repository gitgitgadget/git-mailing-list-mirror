From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] 1/2 : (reworked) Externalizable/Serializable Items
Date: Wed, 18 Feb 2009 13:48:59 -0800
Message-ID: <20090218214859.GN22848@spearce.org>
References: <320075ff0902161212s1980cd70r8cdc4c21550333ee@mail.gmail.com> <20090218163002.GB22848@spearce.org> <200902182159.51027.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nigel Magnay <nigel.magnay@gmail.com>, Git ML <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 22:51:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZuJr-0005do-Ar
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 22:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760774AbZBRVtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 16:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760769AbZBRVtA
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 16:49:00 -0500
Received: from george.spearce.org ([209.20.77.23]:45919 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760759AbZBRVs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 16:48:59 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 13BAB381FF; Wed, 18 Feb 2009 21:48:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200902182159.51027.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110582>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> Shawn wrote:
> > > +            os.writeUTF(KEY_FETCH);
> > > +            os.writeUTF(refspec.toString());
> > > +        }
> > > +
> > > +        for (RefSpec refspec : push) {
> > > +        	os.writeUTF(KEY_PUSH);
> > > +            os.writeUTF(refspec.toString());
> > > +        }
> > 
> > Should we maybe allow RefSpec to serialize itself with
> > os.writeObject() rather than using writeUTF() directly?
> 
> Doesn't the style above make it easy to define and document
> a format that is easy for non-java programs to write and read,
> while writeObject introduces java-centric stuff (depending on
> the full class name etc).

Non-Java reading a Java serialization stream?  Seriously?

-- 
Shawn.
