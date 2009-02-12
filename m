From: "Tilo Schwarz" <tilo@tilo-schwarz.de>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Fri, 13 Feb 2009 00:14:40 +0100
Message-ID: <op.uo9hiqqqa8ed4e@dellschleppa>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa>
 <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jonas Fonseca" <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:16:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXkn4-0006lM-C3
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 00:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759060AbZBLXOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 18:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755017AbZBLXOq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 18:14:46 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:61506 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756713AbZBLXOp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 18:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1234480483; l=1296;
	s=domk; d=tilo-schwarz.de;
	h=In-Reply-To:Content-Transfer-Encoding:References:MIME-Version:
	Content-Type:Cc:From:Subject:To:Date:X-RZG-CLASS-ID:X-RZG-AUTH:
	DomainKey-Signature;
	bh=zU2EUd8W05l6y2LjzrfQF62lWRbeAe4CQUKCMhVOn+4=;
	b=p40BXRotoiZdZ0mwS2ljW77IpL3zb8FBMITqh5YKZ8Vn00L0Pq5flLr88UAPKCUsJxp
	80hwxbGhEK7MIhNHQZp13j4SNYzTb3HPPrY8zcaSrEt6syc4/hCUiSdOP0Mr1rOC1ovfa
	DQXU21JK5zHRkdFTZ9BUTl+3imY4WlvVFPo=
DomainKey-Signature: a=rsa-sha256; s=domk; d=tilo-schwarz.de; c=nofws; q=dns;
	h=X-RZG-AUTH:X-RZG-CLASS-ID:Date:To:Subject:From:Cc:Content-Type:
	MIME-Version:References:Content-Transfer-Encoding:In-Reply-To;
	b=Q6agIFDd/O5XaUGnv/5ze0oTkSSYSsoS+EhWHJ/qnM516zOLTyf45pEuJuGDRLzeeN+
	FC0F87ffTUVc/HC8d782qXxCLHPwBfNgFVptVlHhj+s+Gg7iJyoV5x6ajDHb2Ft6D0U4N
	jwqqWQ1qIYDcZyb1pQzc8S9rYJuf/xCSqhM=
X-RZG-AUTH: :IW0NeWC8cvPlgn0IPTehqi9r6o/0DSXjJ1Me0yWdPTUrUVR0TMXac2ZAlc941cVIhg==
X-RZG-CLASS-ID: mo00
Received: from dellschleppa (p549CC650.dip.t-dialin.net [84.156.198.80])
	by post.strato.de (fruni mo3) (RZmta 18.18)
	with ESMTP id g01196l1CMbtjw ; Fri, 13 Feb 2009 00:14:40 +0100 (MET)
In-Reply-To: <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
User-Agent: Opera Mail/9.63 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109678>

On Thu, 12 Feb 2009 23:24:56 +0100, Jonas Fonseca  
<jonas.fonseca@gmail.com> wrote:

> On Thu, Feb 12, 2009 at 22:48, Tilo Schwarz <tilo@tilo-schwarz.de> wrote:
>> One thing came to my mind. When I use 'S' and then 'u' to stage/unstage
>> files, it would be nice if I could press a key(maybe 'C') to fire up my
>> $EDITOR, enter my commit message, let tig do the commit and find myself  
>> back
>> into the updated status view. Does this sound reasonable?
>
> Sure, you can achieve this very easily. For example, I have the
> following bindings in my ~/.tigrc:
>
>  bind generic + !git commit --amend
>  bind generic . !git commit
>
> With tig-0.14, you can also put bindings in your ~/.gitconfig or the
> project specific .git/config file using:
>
>  [tig "bind"]
>     generic = C !git commit
>     generic = w !firefox http://repo.or.cz/w/tig.git?h=%(commit)
>
> The last one uses "browsing state variables". There is more
> information about those in tigrc(5)[1]

Wow, that flexibility is really impressive!

Then I have another question: Did you ever thought of a branch view, where  
you can see, create, delete and merge the different branches which are in  
a git project.

Best regards,
(oops, I forgot to change this to the lists language in my previous post)

     Tilo
