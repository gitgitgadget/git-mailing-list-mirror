From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of
 ~/.gitconfig
Date: Fri, 25 May 2012 14:17:01 -0500
Message-ID: <20120525191701.GA4944@burratino>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
 <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com>
 <7v4nr4t9gc.fsf@alter.siamese.dyndns.org>
 <20120525182558.GC4491@burratino>
 <7vsjeortwu.fsf@alter.siamese.dyndns.org>
 <20120525184408.GA4740@burratino>
 <7vobpcrstn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 21:17:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY00i-0006YH-BM
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 21:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350Ab2EYTRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 15:17:12 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:36142 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553Ab2EYTRL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 15:17:11 -0400
Received: by ghrr11 with SMTP id r11so649255ghr.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 12:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mJspcLdLRUNZGh5y4+ctHSPMVCHFXViOwn11K7/yO30=;
        b=lUdflHN0Am9+eLw+lzShqJvXCkJWGLPpvVNE3MTgci4+uBV9oS1kn8Ng+EmTPf4KN+
         SI+7tWadJ3E4VQKUxGTuW4BWfV6kuYxdibIEiH2psZLkbo2gmCOFJOIhIXdvehP95sfT
         uRY5IZjiIp7vBhb4MD9tiN4n8KzMDA+ywfiU3VvrOZ848rzTzkS39yVja80MjKPP8kG+
         m5QoqIz5oQ9Wy/ncPQxizjaz7hygJCTkPKP4exgE8p4trQKjiAQP91N4cOy/jSkKnzsf
         MhZCDpHmsURLeLceynJnnSqlUILp06/VSyYj8qaKqbZC40n1G2qnl9LnDZebfjxNp66y
         sgKA==
Received: by 10.50.51.226 with SMTP id n2mr20601igo.3.1337973430317;
        Fri, 25 May 2012 12:17:10 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ey7sm8246827igb.2.2012.05.25.12.17.08
        (version=SSLv3 cipher=OTHER);
        Fri, 25 May 2012 12:17:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vobpcrstn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198510>

Junio C Hamano wrote:

> Why is it bad to keep using ~/.gitconfig in the first place?  The UNIX
> convention to exclude names that begin with dot is not working for you?

Ok, now you're making more sense. :)

I don't think anyone was proposing dropping support for .gitconfig.
But:

Any patch to add support for ~/.config/git should of course take care
to include a rationale that answers this question.  (I am guessing
that putting all user git configuration in one directory is part of
the goal, and separating temporary files like ~/.fontconfig/*.cache*
from configuration files like ~/.mutt/muttrc is another part.)

Ciao,
Jonathan
