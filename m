From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 1/3] Wrap the log text in some nice HTML to highlight the commit message
Date: Fri, 23 Feb 2007 10:02:56 +0000
Message-ID: <200702231003.03361.andyparkins@gmail.com>
References: <200702172200.13461.andyparkins@gmail.com> <200702181044.53115.andyparkins@gmail.com> <e5bfff550702230003o5a24a422h7c52a544318da1d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 23 11:03:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKXGr-0000Mf-Bs
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 11:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbXBWKDM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 05:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbXBWKDM
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 05:03:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:26535 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbXBWKDK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 05:03:10 -0500
Received: by nf-out-0910.google.com with SMTP id o25so808649nfa
        for <git@vger.kernel.org>; Fri, 23 Feb 2007 02:03:09 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LXENCYuBf6A7LkYEzk8OjVRiQA04bWQLvEqFJGc22o6CiDkvmnvGd4M9G3ucBt8UHFHJCjtNL+1OmCeJtzG6UdlVg3iTD53OYvHkAlqP+eeHLHNGdo+PIEPaXCrVoFnhuHmQKzOvAdGtOeMhNP70GIrcQ4Yz9Z27vv/kLIlPfq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PQRJyzRMd4Sby+a8ZASTwartUgUXIA711KD0tec31dnnTEd5zrpX2oW06gI2ijrGz9GCWkkqkp1QjtC2JMmffstWDbhfoWRi4EiNKc58JDS+AtpYswcV+LJcT1qAoqZPMvZTZe3akSsWfGdGQBD25ktdw1IikcUauSyvp4b5qXA=
Received: by 10.49.13.19 with SMTP id q19mr5572745nfi.1172224989159;
        Fri, 23 Feb 2007 02:03:09 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id l38sm8887670nfc.2007.02.23.02.03.06;
        Fri, 23 Feb 2007 02:03:06 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <e5bfff550702230003o5a24a422h7c52a544318da1d4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40435>

On Friday 2007 February 23 08:03, Marco Costalba wrote:
>  I finally apply and pushed your patches to
> git://repo.or.cz/qgit4.git, I have to say I really like your fancy
> html log message.

:-)  I'm glad you like it.  I was trying to make it look a bit like the email 
header in kmail.  I'm a bit disappointed with it aesthetically, but I do find 
it makes it a lot easier to view the separate log components without much 
brain power.

> - Font family is set to TYPE_WRITER_FONT, but font size is not taken
> into account and seems fixed.

Ah yes - probably a one-liner to fix.  I'll patch soon.

> - There are some alignement issues in the header, sometimes author,
> date, etc.. are left shifted without a clear reason wasting valuable
> screen space.

Yes you are certainly correct.  I'm going to point at Qt for the blame.  I 
have no idea why it's adding that space.  It goes away when the rowspan is 
removed from the short log part.  Additionally, Qt (despite the 
documentation) seems to ignore width=100% to table or divs, so I can't make 
the header actually look as nice as it could.

Once I figure out how to make it look better I'll certainly post patches, but 
at the moment it's a fight between me and Qt :-)  The solution, is going to 
be a compromise I think.  I might have to make the short log non-centered and 
non-rowspanning :-(

> Anyway a nice job.

Thanks.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
