From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCHv2] connect: display connection progress
Date: Thu, 10 May 2007 16:52:00 +0200
Message-ID: <81b0412b0705100752wa6dec37t787ccd61266f8944@mail.gmail.com>
References: <20070506195230.GA30339@mellanox.co.il>
	 <20070510095156.GC13655@mellanox.co.il>
	 <81b0412b0705100439j4e6b072bk1ba19a4f971e5d0c@mail.gmail.com>
	 <20070510120802.GG13655@mellanox.co.il>
	 <81b0412b0705100519i3028fbc4y25e7c407c7c8216@mail.gmail.com>
	 <20070510122550.GJ13655@mellanox.co.il>
	 <81b0412b0705100633t61ac0309jfc8536b30244adf6@mail.gmail.com>
	 <20070510134622.GN13655@mellanox.co.il>
	 <81b0412b0705100716t680290a3qd1d10cf588a65f5a@mail.gmail.com>
	 <20070510143913.GF22029@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu May 10 16:52:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmA02-0001Qi-L8
	for gcvg-git@gmane.org; Thu, 10 May 2007 16:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbXEJOwF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 10:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752951AbXEJOwF
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 10:52:05 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:19609 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbXEJOwE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 10:52:04 -0400
Received: by an-out-0708.google.com with SMTP id d18so148145and
        for <git@vger.kernel.org>; Thu, 10 May 2007 07:52:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DiraTaww53csTWnHiIaubRs/Sp7ByRfou458RYncah2jk4l3mUHrhUIZEPBCijMy7JgJARkjb1rTne5oxINgjTcPRgbXb2rVBjRzzaBM86fh4xK/TpqE0mwf6PiDsYhh8gRCR+zBiBn7UW/U7hNatAbIkjpg3EQhORRJ3QGBSmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BJHXhkCjWF8m/dU+w8k1qmWUfi+0W0Tbrs4XjZymXcYH2ix0vX8vec9z5/B8a9JbqzZ0h9LtcsT0WlAvcmEGAP3b72xRmSTV+j7Eh8nMHOHmc3LRzoiYzt8uz6aAdewkiec290lzMkhn7w3UAZi72IBxu0sTIK8lMeLPWdNgOO0=
Received: by 10.100.59.20 with SMTP id h20mr1339134ana.1178808720522;
        Thu, 10 May 2007 07:52:00 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Thu, 10 May 2007 07:52:00 -0700 (PDT)
In-Reply-To: <20070510143913.GF22029@mellanox.co.il>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46870>

On 5/10/07, Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:
> So, that's why the "connecting" message belongs in the default setup
> (it can hang there for minutes), IP and such technicalia
> belong with -v, and -q would only print data on connection error.

How about a config option? So that people working with
repos connected through fast links (say, in local network or
even locally on the same system) are not bothered by the
"connecting" messages (they're is useless then, local networks
usually work).
