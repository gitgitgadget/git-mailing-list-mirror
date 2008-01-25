From: "Marko Kreen" <markokr@gmail.com>
Subject: Re: I'm a total push-over..
Date: Fri, 25 Jan 2008 22:08:09 +0200
Message-ID: <e51f66da0801251208i3d6a78c2xc6e08c509ed4e35e@mail.gmail.com>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
	 <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org>
	 <4797095F.9020602@op5.se>
	 <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>
	 <4797518A.3040704@op5.se>
	 <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com>
	 <4798B633.8040606@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Jan 25 21:08:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIUqz-0005Am-S9
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 21:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbYAYUIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 15:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbYAYUIP
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 15:08:15 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:6253 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbYAYUIO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 15:08:14 -0500
Received: by fk-out-0910.google.com with SMTP id z23so742056fkz.5
        for <git@vger.kernel.org>; Fri, 25 Jan 2008 12:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Jf1LJmc39jMsL/bbSU0lAgVtHeQrwvIPz8khbUJ5d5s=;
        b=e08TcK9g2as/fHTqxBBBiSFyX0V+gBbIaQixlNwZDk9zJZDjLDgZGXP0tA9q9383XElibvfTJkx4v2xP5zNhl1KDntdQOAlhdsW+Gd5SpleK3ttpZ+xWenKmWmN5/uyWjmtDCy7NEd4mfmt1AumYRzRSGuanPTznjBGGAVXYufc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rzattQmhFPtaWHO4iI7Oql3LjiU6lOzJzYbK3j6ki0Mjolfx8bNhtFXreOIbhOY/6YaSiLb3B0hf6JKotUYlLrmBGkRz0uBx7U2j3RkSSz/Y6l3sPopmsYS1E4/P4yIg+57oZx2kHPosp1dI+wEB8JWGkbsMRhqXLaKoboiC5Kk=
Received: by 10.78.195.10 with SMTP id s10mr3672790huf.9.1201291689973;
        Fri, 25 Jan 2008 12:08:09 -0800 (PST)
Received: by 10.78.200.6 with HTTP; Fri, 25 Jan 2008 12:08:09 -0800 (PST)
In-Reply-To: <4798B633.8040606@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71735>

On 1/24/08, Andreas Ericsson <ae@op5.se> wrote:
> Interesting output, but not very surprising. Do you have the code
> available somewhere?

http://pgbouncer.projects.postgresql.org/hashtest/hashtest-2008-01-25.tgz

I cleaned it up a bit.  Also fixed a bug - the lookup3 was called
via wrapper function so it acually is tiny bit faster than the
results show.

You can consider the code as public domain too.  Also remember
the was not meant to be published, so it rather hack...

-- 
marko
