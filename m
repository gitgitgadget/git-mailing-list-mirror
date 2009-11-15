From: Victor Engmark <victor.engmark@gmail.com>
Subject: Re: git svn fetch loses data
Date: Sun, 15 Nov 2009 10:56:38 +0100
Message-ID: <7d4f41f50911150156x4cc07dcch977c90e5bd134d17@mail.gmail.com>
References: <7d4f41f50911140907n285d72dcp7bbe802900f8bae5@mail.gmail.com>
	 <fabb9a1e0911140925r3f7b7806s65da03c046bf5ab4@mail.gmail.com>
	 <7d4f41f50911141129n967374ap7d92296c5723e31e@mail.gmail.com>
	 <fabb9a1e0911141138r5279650ge57db2413e2321a4@mail.gmail.com>
	 <4AFF3EB7.5080606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: "Johan 't Hart" <johanthart@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 10:56:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9bqg-0007RI-5C
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 10:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbZKOJ4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 04:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbZKOJ4d
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 04:56:33 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:45870 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbZKOJ4d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 04:56:33 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1561362eyd.19
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 01:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=gubisLjPYX+H/n/cMA1PbiLexAtOK1Vilk/HqqSyDts=;
        b=QR6CFnm5ikjlfD4Oitkg3DddB8TSCY6sZdy0pgLqXGKpMnMN0UwA6NYHKPix1VUdG+
         KJU4LAP3uBxZM6dCvL2sDVMa667oQ6cdjjhiPTDoxHXpdBZjl4a/+X/pRfZS+uMc8y3x
         S+HmzSTz+U5+YxRNuOIao/D9T7UffGv/tJ48A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=MQP79PRa7FgVctCOyn7E3rLhw4psc7a/b4RuhhvcLyIfYAq8sCL5xIjV3LJLdiQpsx
         uzEqAEYz+XKVAQR3ow2UDKecDOiNDuXOOzYema2+31coz92P64azseKMaFL1Yx13JaDe
         Bl7Z2DQR3T9GuyCT1TV0iZADifeTpGIOR+k0A=
Received: by 10.216.89.129 with SMTP id c1mr576796wef.35.1258278998128; Sun, 
	15 Nov 2009 01:56:38 -0800 (PST)
In-Reply-To: <4AFF3EB7.5080606@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132925>

On Sun, Nov 15, 2009 at 12:35 AM, Johan 't Hart <johanthart@gmail.com> wrote:
> Sverre Rabbelier schreef:
>> On Sat, Nov 14, 2009 at 20:29, Victor Engmark <victor.engmark@gmail.com>
>> wrote:
>>>
>>> Do I need to run something after fetch to see them?
>>
>> Your working copy is probably not up to date anymore, try:
>>
>> $ git rebase git-svn
>>
> Why not just
> $ git svn rebase
> ?

What is the difference between the two?

-- 
Victor Engmark
