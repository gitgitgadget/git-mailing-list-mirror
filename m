From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [MinGW port] Unable to repack on Clearcase dynamic views
Date: Wed, 30 May 2007 15:48:18 -0400
Message-ID: <fcaeb9bf0705301248o4609d532p60ba24805fa0e5ad@mail.gmail.com>
References: <fcaeb9bf0705300742u22b54c78vccbc037fb553141f@mail.gmail.com>
	 <200705302028.15549.robin.rosenberg.lists@dewire.com>
	 <fcaeb9bf0705301208p6ce00315uc3cde4d43903ec0c@mail.gmail.com>
	 <200705302128.34111.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Paolo Teti" <paolo.teti@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Lederhofer" <matled@gmx.net>,
	"Junio C Hamano" <junkio@cox.net>
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed May 30 21:48:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtU9l-00046h-US
	for gcvg-git@gmane.org; Wed, 30 May 2007 21:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbXE3TsY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 15:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753536AbXE3TsY
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 15:48:24 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:11659 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbXE3TsX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 15:48:23 -0400
Received: by an-out-0708.google.com with SMTP id d31so752875and
        for <git@vger.kernel.org>; Wed, 30 May 2007 12:48:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=llimkeFPL/NxUNHkhT7fsfIeb2b4/jOmlHsIg+jjokCzcXodw2PCv+pSsdpOlKCoGommMgvpUJMIr10F5/WXAgqgeV0LM9PSOPEdmNLPZ5TBQ6C4KGZm7pAWQiowR6n0cIWGry+xE2/Aj9ITyK1+/Pb2lGoc8K1WBaKw+ClnZr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VFy95spr2UZleEmb0j6qjprbOiEz8iF5dP6xtU32jie2zFR3Lr+F9312Oh0ovVQf8+2kdJXTXciUUuHxd5Gzlh3uW3zhY+uR+FckrNq5Y2ntvfFwIBqyxHPkDodmto3wP+bM0JyolXvP6dByjyeTlfklPQTucbmaLZQhYljZ1tQ=
Received: by 10.100.227.5 with SMTP id z5mr6283562ang.1180554499047;
        Wed, 30 May 2007 12:48:19 -0700 (PDT)
Received: by 10.100.127.2 with HTTP; Wed, 30 May 2007 12:48:18 -0700 (PDT)
In-Reply-To: <200705302128.34111.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48785>

On 5/30/07, Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> onsdag 30 maj 2007 skrev Nguyen Thai Ngoc Duy:
> > Clearcase symlinks require checkout/checkin stuffs that I really don't
> > want to mess up with. Moreover, it seems not work if the link
> > destination is out of clearcase view (which is what I wanted).
>
> Well obviously.. :/
>
> I guess junction points in dynamic views are out of the question too. Would
> setting GIT_DIR be too cumbersome?

Well, I've got the same errors as before in this thread :)
http://thread.gmane.org/gmane.comp.version-control.git/41586
-- 
Duy
