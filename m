From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] fast-import: let importers retrieve blobs
Date: Fri, 3 Dec 2010 14:26:50 -0600
Message-ID: <20101203202650.GA15517@burratino>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <20101128194131.GA19998@burratino>
 <20101128194501.GD19998@burratino>
 <201012031130.06008.trast@student.ethz.ch>
 <7vsjyeobka.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 21:34:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POcKr-00087K-54
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 21:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580Ab0LCUeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 15:34:24 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:33861 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab0LCUeX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 15:34:23 -0500
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2010 15:34:23 EST
Received: by mail-ew0-f45.google.com with SMTP id 10so5933885ewy.4
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 12:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QbWERl4TQ2tCS0MzRevyYKuCI+2weYdAX+/c/3Jn8aw=;
        b=j9ZCvWWKpttH48YwlrtBOQWF9vD/Fl5I7yHiXzr5RFBNM0JFja8J8C9tLN0DY8+kcg
         JSKTD/g7ExwR7zk/P6k8cJx4XoE7RBWvx9889hKryPssdN95DviMoaHTKBnoAU44fuEG
         EZhUqH8jrAuL7sjG51MzZpdi1E6ilIx3BK7fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AUZpwNTsQgrq+J0iBJUYAoXacFCuMyqdor4su1ZMREgEX1pSZCeuJoA0rXMDh3GjB4
         N2RNAsFXgI9uXJYJFno1FUbJWkt3gDggL/qHz7ny3CUaTNINteTpltXFm/BOC9ewWVQX
         /Qt/V0Q1oZqsoxZnIPGNMXjuruq51iqFlF4GA=
Received: by 10.213.22.66 with SMTP id m2mr1330064ebb.76.1291408026713;
        Fri, 03 Dec 2010 12:27:06 -0800 (PST)
Received: from burratino ([68.255.109.73])
        by mx.google.com with ESMTPS id q58sm1847170eeh.3.2010.12.03.12.27.04
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 12:27:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vsjyeobka.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162846>

Junio C Hamano wrote:

> Output from
> 
>     $ git grep -n -e /dev/ --and --not -e /dev/null t/

FWIW

	$ git grep -e 'dd if='

shows a few missed harmless examples.  Perhaps

	$ git grep -e '/dev/[^n]'

would have been the simplest way to catch them.
