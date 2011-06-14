From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Tue, 14 Jun 2011 09:51:18 +0200
Message-ID: <201106140951.19227.jnareb@gmail.com>
References: <201106051311.00951.jnareb@gmail.com> <201106131215.24343.jnareb@gmail.com> <4DF6E1C0.5000503@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 09:52:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWOQ6-0005MQ-N8
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 09:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936Ab1FNHwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 03:52:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63811 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab1FNHwM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 03:52:12 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so3367147fxm.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 00:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=IsiRbDRNBHalp32q8VFnOGDqJSt4higZu43GyzhVU30=;
        b=f3FQMtzuycz5ClMgW/SUGQ0yjtv+seNJwWdP6EOj8WZh1pkbuxuDj97oPagRg7vmK+
         HJiM1fmtu/FXSx+DKYPolMfhrBOooc4LsFHs/ncfW4+u8ESV8qYxMg6urdqpzjptsvP7
         aj25uKGl78kTuQHK4w/5nljg1u2TzJNfhqR3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tr7DD2T+GQJuVUlr5tuNhQP5Fyj4xGkQPl7q3K59xAJaM85Uy2ljIeErymLqeY7S4O
         EAU7Hu9Lslr0ukGldLde8LL+58ShvnvRQWz1yu39KmxEL8ccSoiPr55eu1+Xp5kXzq42
         qFiwP4hXeAXU0+X81Eb1rs+RAXDuG+Z+HxEDo=
Received: by 10.223.32.142 with SMTP id c14mr950068fad.59.1308037932002;
        Tue, 14 Jun 2011 00:52:12 -0700 (PDT)
Received: from [192.168.1.15] (abwt98.neoplus.adsl.tpnet.pl [83.8.243.98])
        by mx.google.com with ESMTPS id h9sm2500143fai.30.2011.06.14.00.52.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Jun 2011 00:52:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4DF6E1C0.5000503@alum.mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175751>

On Thu, 14 Jun 2011, Michael Haggerty wrote:
> On 06/13/2011 12:15 PM, Jakub Narebski wrote:

> > BTW. there is code for 'git put'.  Where is code for git diff targets?
> 
> Is this just a rhetorical question, or would code be useful?  From the
> tone of the conversation, I got the impression that the change has no
> chance of being accepted.

It was not entirely rhetorical question.

First, code speak louder than words. A feature for which there exist
implementation (and documentation, and tests) has much more chance being
accepted / merged in, than purely theoretical discussion on user
interface. Though the latter is needed too, of course.

Second, writing proof of concept implementation, or at least trying
to write documentation and/or test for new feature or new behavior
help to flesh out ideas, to give them definite shape.


But I know that not everybody is a programmer, and from those not all
are proficient in C (at least for this case), Perl, Python or shell
scripting, and with Git API to implement new feature.

-- 
Jakub Narebski
Poland
