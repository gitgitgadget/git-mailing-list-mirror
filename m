From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: git-gui blametool
Date: Mon, 12 Feb 2007 23:06:02 +0530
Message-ID: <cc723f590702120936y64044ac4r86698b5d7e540bd8@mail.gmail.com>
References: <45D07A76.1070009@gmail.com> <20070212173218.GD29621@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 18:36:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGf60-0002OQ-5I
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 18:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbXBLRgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 12:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbXBLRgE
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 12:36:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:43217 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965022AbXBLRgD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 12:36:03 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2348680nfa
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 09:36:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uPMpJl2u77kpRqO7rkTdwtyOdoQUbw8yWVLG4Xs6qIhcjx+zeQ/N5X1pDRDrmYuMaWtPhDpfR6FhioLUwRtT2L6WS2pcAjfCpgfhcOYDi5wLfvtQ0lnZKmuiigKoT45daExNi1FjgGeXmEp+QEqJ1Ed6Yyhp/SUj+cL3BY80Rso=
Received: by 10.49.57.1 with SMTP id j1mr4815735nfk.1171301762087;
        Mon, 12 Feb 2007 09:36:02 -0800 (PST)
Received: by 10.48.210.15 with HTTP; Mon, 12 Feb 2007 09:36:02 -0800 (PST)
In-Reply-To: <20070212173218.GD29621@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39421>

On 2/12/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@gmail.com> wrote:
> > I found the git-gui blame tool interface quiet confusing with the all
> > those color code. What does the color code actually mean ?
>
> Can you try the version of git-gui that Junio pushed out to `master`
> last night?
>
> > A simple
> > interface would be
> >
> > [ commit ] [ line number ] [ code ]
> >
> > ....
> > ...
> > --------------------------------------
> > commit details of the selected commit
>
> Because it uses this interface.  Almost.  It doesn't show the
> [commit] column.
>

I tried the same one. I was requesting to add the commit column. Right
now the interface is pretty confusing. After some reading of the code
i figured out that colours have a specific meaning. May be we need to
add a manual to the same.

but any how having commit in a column like this is really nice. I just
sent a new patch for blameview. That should give an idea how much the
interface looks better.

-aneesh
