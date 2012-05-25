From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of
 ~/.gitconfig
Date: Fri, 25 May 2012 14:37:24 -0500
Message-ID: <20120525193724.GB5184@burratino>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
 <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com>
 <7v4nr4t9gc.fsf@alter.siamese.dyndns.org>
 <20120525182558.GC4491@burratino>
 <7vsjeortwu.fsf@alter.siamese.dyndns.org>
 <20120525184408.GA4740@burratino>
 <7vobpcrstn.fsf@alter.siamese.dyndns.org>
 <20120525191701.GA4944@burratino>
 <vpqvcjknjo0.fsf@bauges.imag.fr>
 <20120525193507.GA5184@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 25 21:37:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY0KQ-0002Rp-15
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 21:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280Ab2EYThb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 15:37:31 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:45271 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758481Ab2EYTh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 15:37:28 -0400
Received: by gglu4 with SMTP id u4so1105941ggl.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TkAuVZbSnDgjTJMNJzeEzuE+eMFy/Tpu6azCjWev6z0=;
        b=Hu80fQjH/D5oxeEd6EZJRB9qRds0+68z0Nc6W3mMYOynKiFzEKKIdtnQbsGu7gdnJW
         8IplU3KWRDsZvZDR1QdSPeW10ny0JGhhlAGXRub4vKe7oaHdeknxrguXwQX/hV0hCICI
         WCRXXA0yqIB0MewCBCq6hHyOEbm5FGrPDsRbQnDeZBn9TdicB2zCzH/8e3cJ26nqWezf
         TjkyNc4iR5oSQcgwS4VVw4FjmzXp9/eErpBqPlscUTSz2oJ+QNvvXHJSDLnF3jn9n0ck
         C5/jTfnxl5iRCVWBBhsBJ9Tp8qHvBsDu5l3S+b+rX1PCMMVPrvrrf9Kvj87UxQKCf3Wo
         1kXg==
Received: by 10.50.76.163 with SMTP id l3mr94801igw.55.1337974648017;
        Fri, 25 May 2012 12:37:28 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id k6sm8285847igw.14.2012.05.25.12.37.27
        (version=SSLv3 cipher=OTHER);
        Fri, 25 May 2012 12:37:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120525193507.GA5184@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198514>

Jonathan Nieder wrote:
>            as Junio wrote before[1]:

>> It is not _too_ bad to treat ~/.gitconfig specially and support reading
>> from ~/.$SOMEGITTTYNAME/{excludes,attributes} files.
>
> That's what vim does --- its main configuration file is ~/.vimrc, and
> there are also some supporting files in ~/.config/vim/.
>
> Wouldn't that be a good place to start?

Correction: I meant "also some supporting files in ~/.vim/".

Sorry for the noise.
Jonathan
