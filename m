From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 2/1] bash: eliminate dependency on bash_completion lib
Date: Tue, 7 Dec 2010 14:59:51 -0600
Message-ID: <20101207205951.GB25008@burratino>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
 <20101202091624.GB1771@burratino>
 <20101202091613.6ac8f816@MonteCarlo.grandprix.int>
 <20101202210207.GA4994@burratino>
 <20101207160747.GD1867@neumann>
 <20101207194923.GD22587@burratino>
 <20101207204104.GE1867@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter van der Does <peter@avirtualhome.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Dec 07 22:00:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ4dw-0003CX-53
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 22:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141Ab0LGVAF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 16:00:05 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:35515 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab0LGVAD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 16:00:03 -0500
Received: by fxm18 with SMTP id 18so296491fxm.2
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 13:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=eZMhK4Szu8Ucrd3VdpAog6Vhq5dAJnrewKxWkyMUaz0=;
        b=blAVTEXvxR0n9S66LQWdi9JaWthrsWqDG+wnIpA+qeL5YKVkl4cAq+kFr4SuTKb4hh
         xBqOPKcHYkoy4vl3aoaJbg1cxbP1wGkzLU5cijMqNmP9l9MMobWE67fWxZb09eBGadNA
         PherwseA0lwkAym3ie6KDwKl/tsh3teJcjiWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=HP/mbrmzYvtxa731YO3peVjBJtCCws9n4tC1FXHSyFukoPo/RCKTmfgw4OXGRZs51f
         3nNUSd+bxu92xVdJIAFdTpwDxt50L2bSQ8Nx3yVkZKxFlk1aV1NDBdsnLkossyLu5bwD
         SE9NZA7JbNsCDrkruNOM/iwZ4u6+beILEC3Kk=
Received: by 10.223.116.1 with SMTP id k1mr7602210faq.51.1291755602463;
        Tue, 07 Dec 2010 13:00:02 -0800 (PST)
Received: from burratino ([68.255.109.73])
        by mx.google.com with ESMTPS id n15sm2082580fam.12.2010.12.07.12.59.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 13:00:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101207204104.GE1867@neumann>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163132>

SZEDER G=C3=A1bor wrote:
> On Tue, Dec 07, 2010 at 01:49:23PM -0600, Jonathan Nieder wrote:

>> Ah, sorry, applies to d93f4a297 (bash: work around bash 4.0 change i=
n
>> COMP_WORDS semantics, 2010-12-02).
>
> In which repo? ;)

Thanks.  I had meant to say that patch 1 applies to 06f44c3c
(completion: make compatible with zsh, 2010-09-06) and that the bash 4
support could be rebased to work without that if there is demand.

*goes off to get some coffee*

Sorry for the confusion.
Jonathan
