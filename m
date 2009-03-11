From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 14:34:09 +0530
Message-ID: <ab9fa62a0903110204o5b436a58v848905319e579753@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.LNX.1.00.0903110147270.19665@iabervon.org>
	 <ab9fa62a0903102317l3a7322f7w5e4d9ba0e02af37b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 10:06:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhKNh-0004DR-1z
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 10:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbZCKJEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 05:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbZCKJEN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 05:04:13 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:64092 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbZCKJEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 05:04:12 -0400
Received: by yw-out-2324.google.com with SMTP id 5so438526ywh.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 02:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=C0QWE+ISnZfCwIQ95MnWR3NlFdt/ru0DqlJ08SmEBUQ=;
        b=wFTGp5ZB4Bq3ABeXapntIHJWUYfiDRdclUxt03XGkiLlk79XDSSqlVDxa/g/Lyesy/
         P4X5p3Etgt/w7RcrQx/9xLO4H+AcAwqNQjBwhuw9+cJtjmaF31UCVcBNxMsRey3kY9AD
         GF6ge2hJc8FndZ4n8f+0aVERjxJ2Ic8k5I3tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=mywi44UMbh2bbZW4+HrXALnifA5o/kKOqdg+KzBESGEnfPu4FDha2r6MZ/guN+9vIf
         6YrkYjaIP5BEjQnxqT1NVD6eBk0PvkqMUPq0F6GzrNUGOI4LpzwKCe/8rJxP4B4WGKjx
         9b7061mK5IA+asj44J4a+1ZSZkKur5484gP+M=
Received: by 10.231.19.70 with SMTP id z6mr1940815iba.32.1236762249234; Wed, 
	11 Mar 2009 02:04:09 -0700 (PDT)
In-Reply-To: <ab9fa62a0903102317l3a7322f7w5e4d9ba0e02af37b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112896>

hello,

On Wed, Mar 11, 2009 at 11:26 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
>
> On Wed, 11 Mar 2009, Saurabh Gupta wrote:
>
> >
> > /*About GSoC GIT ideas;
> > */Here are the ideas which I found to be interested in. Although, I
> > would like to discuss any other idea than these in GIT organization.
> >
> > *1) Domain specific merge helpers*
> > Intelligence in the merger can be put which modifies the source file
> > according the format. Different file formats can be put in the merger
> > to support.
>
> This is something I've thought would be really handy for making git more
> widely useful. The hard part, of course, is coming up with useful
> alternative merge algorithms which work for formats that the usual merge
> doesn't handle. The infrastructure is mostly there (git supports declaring
> the types of files), but there's no point in support for running a
> type-specific merger until there are actually type-specific mergers to
> run.
>
> Do you have ideas on what formats you'd try to merge, and how?

Well, What I think is to implement file formats other than text like
that written on wiki i.e. latex, xml, or even any database file (db
file).  Another idea (although it can be weired also) is to implement
the new file formats in the plug-in formats. For example, to
incorporate the merger engine for a new file format, a plug-in is
created and can be integrated with the present merger in the git.
However, I am not sure how much valid is this idea to make the present
merger in git to be compatible with the plug-ins for enabling newer
file formats.

Any new idea or suggestions are welcome.



-- 
Saurabh Gupta
Senior,
Electronics and Communication Engg.
NSIT,New Delhi, India
