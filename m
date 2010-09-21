From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [tig] Re: compilation error: undefined reference to `set_tabsize'
Date: Tue, 21 Sep 2010 19:34:37 +0200
Message-ID: <20100921173437.GA13013@vidovic>
References: <20100920174200.GA13017@vidovic>
 <loom.20100920T203217-346@post.gmane.org>
 <20100920204344.GB13017@vidovic>
 <20100920230559.GJ23119@bowser.ece.utexas.edu>
 <20100920231349.GK23119@bowser.ece.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Stefan =?iso-8859-1?Q?N=E4we?= <stefan.naewe@googlemail.com>,
	fonseca@diku.dk
To: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
X-From: git-owner@vger.kernel.org Tue Sep 21 19:35:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy6kY-0003nQ-5j
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 19:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757976Ab0IURfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 13:35:08 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33733 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757949Ab0IURfG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 13:35:06 -0400
Received: by wwi17 with SMTP id 17so240197wwi.1
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=bi2cv4ma+lChwdtnFgq0Wa+zyFnoJe/ivxQEL5kstnc=;
        b=o+tVSR/qDuNRyK8zUtEkmSXK8d3olZ+lpBsJtcNxsEVjApvCHovmuHcCVQhjO5kZzn
         CSP7YgkdItloD6iTQhG/1Xi0FO7j8bQJ8H5BYYsRbgfrR3fynJUNfihYOXg/RJpzmQVZ
         j9XyHWHEPBnMpAG04jLNv06+pMhAN83E7t7qE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aehOsd3mgJQM/lNnZECZUfYh2oLC9+2yamP+tnr3NjXQhv7q4TtrtwzXttM2JPXWCA
         ISsdTJui+WtitWX2ezME61U5jBW/7xZeXc4gi4q3lk0TxvOxYq0xNPguUT6mFASX2CER
         x08jpDSb3RbCtdUqbjayxz+9QJwIb60qh6EnA=
Received: by 10.227.142.136 with SMTP id q8mr3620698wbu.95.1285090481934;
        Tue, 21 Sep 2010 10:34:41 -0700 (PDT)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id m5sm1706255wbc.9.2010.09.21.10.34.39
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 21 Sep 2010 10:34:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100920231349.GK23119@bowser.ece.utexas.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156733>

The 20/09/10, Kumar Appaiah wrote:
> On Mon, Sep 20, 2010 at 06:05:59PM -0500, Kumar Appaiah wrote:

> > Ack that this also breaks build on CentOS. The simple reason is that
> > the ncurses version on CentOS 5.5 is ncurses-5.5, while that on Debian
> > Lenny is 5.7+. According to the changelog, 5.6 onwards has
> > set_tabsize, so checking for that version of ncurses might be a good
> > option.
> 
> I have attached a patch which uses the patch number to determine this:

Thanks Kumar, it did it (with ncurses v5.6)! :-)

-- 
Nicolas Sebrecht
