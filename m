From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: gateway status?
Date: Wed, 17 May 2006 01:09:19 +1200
Message-ID: <46a038f90605160609u19a356ccx9467c32100731b9@mail.gmail.com>
References: <Pine.LNX.4.62.0605151122500.29452@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 15:15:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfzIh-0000km-SJ
	for gcvg-git@gmane.org; Tue, 16 May 2006 15:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWEPNJU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 09:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWEPNJU
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 09:09:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:43652 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751815AbWEPNJU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 09:09:20 -0400
Received: by wr-out-0506.google.com with SMTP id i22so1480495wra
        for <git@vger.kernel.org>; Tue, 16 May 2006 06:09:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EqgO6gOhbdhiuCobbjUvSisTbtVSbmCC/lMZMWzBxnZBUTJkdK7R/hmUKW/dV3ncouiTBhcOdVBSmP49vn6Jaib3leYPD8BPGxhVSTAZdXQTKuYfqpe+kJMdXnt+oNl4dMjUL9ZV2mTUAV0GlkuRwjaky9/iidBCL3aUBLdvXm0=
Received: by 10.54.60.26 with SMTP id i26mr4935999wra;
        Tue, 16 May 2006 06:09:19 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Tue, 16 May 2006 06:09:19 -0700 (PDT)
To: "David Lang" <dlang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.62.0605151122500.29452@qynat.qvtvafvgr.pbz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20121>

On 5/16/06, David Lang <dlang@digitalinsight.com> wrote:
> I seem to remember seeing discussion of gateways to cvs/svn that would let
> a project use a git repository and allow clients to use cvs/svn clients to
> retreive data.

David,

I suspect you might be thinking of git-cvsserver. The code has no
known bugs, but is has only seen limited use by in-house dev teams.

A good measure is to run an import of the current cvs project (I would
try both git-cvsimport and parsecvs) and then get a checkout via
git-cvsserver.

Works great with traditional cvs cli and well behaved clients (TortoiseCVS).

> am I remembering correctly, and are these tools ready for production use?
> the popfile project is getting ready to abandon sourceforge and move to
> self-hosting, but before I suggest that they use git I need to know the
> current status of these projects (I think the ability to export directly
> into the other interfaces is a significant advantage)

Moodle (a project I hack on) is in a similar situation, specially
after the SF.net debacle with CVS. It is very likely that it will move
to git with git-cvsserver providing "anon cvs" and cvs over ssh to a
very limited set of people with commit rights but no development
knowledge (translators, etc). So there is a path forward.

cheers,



martin
