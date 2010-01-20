From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git locate
Date: Wed, 20 Jan 2010 11:06:19 +0100
Message-ID: <201001201106.20739.jnareb@gmail.com>
References: <43d8ce651001191717l58d10919j691f4e5b056fe9b5@mail.gmail.com> <m3zl49bk0o.fsf@localhost.localdomain> <alpine.DEB.1.00.1001201021060.31129@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 20 11:06:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXXSN-0006z6-56
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 11:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379Ab0ATKGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 05:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167Ab0ATKGb
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 05:06:31 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:46511 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab0ATKGa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 05:06:30 -0500
Received: by fxm25 with SMTP id 25so363943fxm.21
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 02:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Iow2sbrpZqbU4v0EBgoNnnY+HDahk09s25jBTYt6ASc=;
        b=MJeHx3SP0O4+YJVzGh6YHr1zDo7rvVtwq0VsYqQ+FaiqgqbLbDKC25fX/L/csaUviE
         N8FOrlAhawybDqzwU1RKE+0uyZT28m6uO3w6KXNDilhbyuMpqS3PFSIXOJ98xSQaaf2L
         6u50zNCl6pIgAQo6CE90YnZ51D5tvJRkFVOjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=h4+tMmiy2h7eEsyZWVGMd7om6g1yogfjtbpIE4YmSFxFcm1PWj6oMy3FEIgk+KXlgY
         y2jOeC4FWzA9PjM+/+Oc0VYLBaHh5HFBHHkKNOYwDuEersy9cds3Ac059XnrG40Af8SG
         5qHKgU1ahyMKA16lRjZ1efndy6llb+4Ej8Hbg=
Received: by 10.223.81.81 with SMTP id w17mr3158059fak.2.1263981989228;
        Wed, 20 Jan 2010 02:06:29 -0800 (PST)
Received: from ?192.168.1.13? (abvs157.neoplus.adsl.tpnet.pl [83.8.216.157])
        by mx.google.com with ESMTPS id 15sm3559929fxm.2.2010.01.20.02.06.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Jan 2010 02:06:27 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.1001201021060.31129@intel-tinevez-2-302>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137534>

On Wed, 20 Jan 2010, Johannes Schindelin wrote:
> On Tue, 19 Jan 2010, Jakub Narebski wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>> On Wed, 20 Jan 2010, John Tapsell wrote:
>>> 
>>>>   Could we add a:  git locate <filename>       or git find <filename>
>>> 
>>> How about "git ls-files \*<filename>"?
>> 
>> Or "git ls-files '*filename'...
>> 
>> ... but how to make an (git) alias for this?
> 
> Add something like this to your $HOME/.gitconfig:
> 
> [alias]
>         locate = !sh -c 'git ls-files "\\*$1"' -

Thanks a lot, Dscho!


I think it would be nice to have this trick 

  alias.<cmd> = !sh -c '<commands with $1, $@, $#>' -

described in git-config (alias) documentation.  Unfortunately I don't
understand this trick well enough to do it myself...

-- 
Jakub Narebski
Poland
