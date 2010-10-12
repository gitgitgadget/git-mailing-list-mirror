From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/7] Teach fast-import to print the id of each imported commit
Date: Wed, 13 Oct 2010 01:05:32 +0200
Message-ID: <AANLkTimQ3U4C53utXkB-NvWyZpXEut+5OuzLrTiTJryr@mail.gmail.com>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-2-git-send-email-david.barr@cordelta.com> <20101012220625.GA15587@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 01:05:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5nuw-0000f2-Rh
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 01:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402Ab0JLXFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 19:05:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35882 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab0JLXFx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 19:05:53 -0400
Received: by gwj17 with SMTP id 17so1630345gwj.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 16:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=dsPZYv2abG9pp5rxtJVl5YyEg+wuNtYYpm7TikmsDlA=;
        b=M+nwRv7A7+JviqY8Qbs2sVP92naOROrJGMCyd/PLH+wmIWp2u5gDGZNisxzcGBFXQl
         cd7q6/S+ZdIJgoYdnoiCXdE08/tc57/nyLSZjGAzHHY31m3vwUwEwClJvwRB8eZ3L+Cn
         s9dFTksbl0cg5mtGUrP1pU1VtxR21Y6ex5ID0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=B00lOgZwGHtBXgIkcN1330iokPWWX6tNJdMN6U9e6zLfNB5e9whyNhrneYZ7yv8WFD
         sfgkHDdefGHIrS0kDBU6orYAjLdUz7qWs8fJ6wL4Hhuk8wQD+bxqIle/NIbM+NEI8Rag
         QY+I2FaQ7t0y/O1MJw+vKJQRSIooSQ59OJxvU=
Received: by 10.151.11.1 with SMTP id o1mr4017698ybi.215.1286924752527; Tue,
 12 Oct 2010 16:05:52 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Tue, 12 Oct 2010 16:05:32 -0700 (PDT)
In-Reply-To: <20101012220625.GA15587@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158893>

Heya,

On Wed, Oct 13, 2010 at 00:06, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> +/* Where to report commits */
>> +static int report_fd = -1;
>
> This aspect is still useful (for use by the cat command). :)

Perhaps this part should be folded in with the cat command then?
Otherwise it'd be impossible to test.

-- 
Cheers,

Sverre Rabbelier
