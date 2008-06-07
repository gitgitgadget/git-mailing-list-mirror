From: "Cedric Vivier" <cedricv@neonux.com>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Sat, 7 Jun 2008 02:13:36 +0200
Message-ID: <d45085aa0806061713k72108a87qa6635a5935732f20@mail.gmail.com>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>
	 <alpine.DEB.1.00.0806051946100.21190@racer> <484969F0.1030704@gnu.org>
	 <alpine.DEB.1.00.0806061911300.1783@racer>
	 <Jx4nZtFGdU-iUxlX24G6lzMyWe99Z53jtjQp9T9qkMJ1iZC0eZW6xg@cipher.nrlssc.navy.mil>
	 <d45085aa0806061417ue3f1f51i6580acbb51070e5b@mail.gmail.com>
	 <alpine.DEB.1.00.0806070006150.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Paolo Bonzini" <bonzini@gnu.org>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 07 02:14:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4m4l-0004R3-MT
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 02:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753829AbYFGANi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 20:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753822AbYFGANi
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 20:13:38 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:62305 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbYFGANh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 20:13:37 -0400
Received: by wa-out-1112.google.com with SMTP id j37so914147waf.23
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 17:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=DappXWiozFjErRORCSu8tF0kuymLJV8svu9UmuAd/KQ=;
        b=XORrTUVDukQhvftmYx2L9dLWTnk4nPRsP5248axxEuvv8cOTO5EzCtH2ArZWbW7TFA
         Q5kbGMcW3RaobpqmA46t+fqkDOZ0eWV5g8XXPilF3lgHSXfVCzruLQRwDGy/MJOE82+Z
         CcwK3Ep13HypHYH1G4swr5V1Ctz+fzNFHAgFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=JNFG306MrkVizuSmU5Eo3mbZmorFB1ay4r48SgS2IxjZy3dThAABCv/MQOBW3rzMy1
         +uwhNYmGE9XMcd/dHZm67dg7XsSnvC2a3Q3dFuMEl5ZUaHecK5LwF9f5Vwq8Tg01zlyo
         sEzhaR84PbfJ8l4FWwsyG/wKafGx+RioPrhT4=
Received: by 10.114.161.11 with SMTP id j11mr906235wae.105.1212797617206;
        Fri, 06 Jun 2008 17:13:37 -0700 (PDT)
Received: by 10.115.33.3 with HTTP; Fri, 6 Jun 2008 17:13:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806070006150.1783@racer>
Content-Disposition: inline
X-Google-Sender-Auth: 684b0cc6a5791fce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84151>

On Sat, Jun 7, 2008 at 1:06 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> On Fri, Jun 6, 2008 at 11:04 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> > But can't that be just as easily done by piping through sort? (I
>> > understand there is a platform which lacks the sort utility, boohoo)
>>
>> Yes, but sort does not have a natural sort option afaik.
>
> sort -n

Hi!

It is not natural sort but usual boring non-natural numeric sort ;)
With the use-case in original post the list would appear exactly the
same than with strcmp sort.
