From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cg-mkpatch use case
Date: Wed, 3 May 2006 09:41:36 +1200
Message-ID: <46a038f90605021441t25152f7dtfed3828cd601b806@mail.gmail.com>
References: <44570E8E.5070402@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 23:41:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb2cn-0005lv-1p
	for gcvg-git@gmane.org; Tue, 02 May 2006 23:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWEBVli (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 17:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWEBVlh
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 17:41:37 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:23780 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964990AbWEBVlh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 17:41:37 -0400
Received: by wr-out-0506.google.com with SMTP id 36so13647wra
        for <git@vger.kernel.org>; Tue, 02 May 2006 14:41:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m5l95nHZdEra3l+TUI3Mqx7VBnhedh0Wny1DaNdjOTKwQW3sUNttaiU11pXKU66T9NdCiHc8GremzoXouRUDWokxWKKIvG9xM/keSwR+7DeeLHYB0uLux8GEK5/DN7IbQYZkcgEtR5aRnqUy6waDLC/YYmqvK3aRytZqDTkqggc=
Received: by 10.54.66.17 with SMTP id o17mr1148252wra;
        Tue, 02 May 2006 14:41:36 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Tue, 2 May 2006 14:41:36 -0700 (PDT)
To: Belmar-Letelier <luis@itaapy.com>
In-Reply-To: <44570E8E.5070402@itaapy.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19428>

On 5/2/06, Belmar-Letelier <luis@itaapy.com> wrote:
>    What is the Cogito way to apply the result of "cg-mkpatch"

AFAIK, cg-patch. However, cg-mkpatch appeared before cg-patch, so you
may have a version of Cogito without cg-patch.

> 2. What are the difference between usecases with "cg-mkpatch"
>    and "git-format-patch" ?

If you are familiar with git tools, use them instead of cg tools ;-)

Cg is simpler, so if you have relatively simple needs, or a team with
simple needs that doesn't need to know all the git tricks and
internals, it can be a timesaver. In my team, people start with Cg and
eventually evolve into using more and more of git.

cheers,


martin
