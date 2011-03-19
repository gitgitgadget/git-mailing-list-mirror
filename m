From: =?GB2312?B?0Oy1zw==?= <xudifsd@gmail.com>
Subject: Re: About Summer of code idea -- better big-file support
Date: Sat, 19 Mar 2011 22:28:11 +0800
Message-ID: <AANLkTikp5GS0gnqLVgZY4E0wBDmQBp1iftOON3MSMHea@mail.gmail.com>
References: <AANLkTi=Z_4cGBSPQW2YVuj=dd8mcO4YQ0G2owknt7vfw@mail.gmail.com>
	<AANLkTikHigPhaWkiozsurbxjvR5WkAGW9LUtFRT9tK8=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 15:28:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0x8o-0002xS-2u
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 15:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557Ab1CSO2P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 10:28:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44585 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab1CSO2O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 10:28:14 -0400
Received: by iwn34 with SMTP id 34so4957610iwn.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FCXLOaK8GZOv5dCh9gRKjBTFhsbBf/eXhS7eD3akXks=;
        b=q7+FrC+w2pEowHpyX7R+LsTy2PkUU0XaXNis++FLRjgJKQqTNFl+eeZJYBTtl+J2D+
         6u3V2/aMa0XgT4uLYbDy2M0m5JV3P3u9Wj2atGwwOTZ4JvnW3Zs2/MqqGmwsVTsiQLtJ
         oYNub2Z9GTaINDAiU+k5dcVkxldc2Yvc1jqv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BpNGAR/BFW2XNkc4pQGeJ468YskIRfyzAaBEOYYCqwfZ+HzSKvEDRyqId00+oV6OeL
         +CoDKqEKx09/j36+nsCY6LonqhXjKhgtxeFu1GxHo9MK2roYn0ufeSky7xVNd/b3djOH
         NMHfd2ooPBvUWQZQnEF+W2BAQhNCo7dErmGRU=
Received: by 10.42.131.10 with SMTP id x10mr3412925ics.206.1300544891849; Sat,
 19 Mar 2011 07:28:11 -0700 (PDT)
Received: by 10.42.174.201 with HTTP; Sat, 19 Mar 2011 07:28:11 -0700 (PDT)
In-Reply-To: <AANLkTikHigPhaWkiozsurbxjvR5WkAGW9LUtFRT9tK8=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169432>

2011/3/19, Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> 2011/3/19 =D0=EC=B5=CF <xudifsd@gmail.com>:
>> So, how do you guys think about that we can test the file type, and =
then
>> decide to use zlib or not?
>
> We already have core.bigFileThreshold, which can be used to determine
> storage type (traditional one with zlib, or some fancy ones for big
> files). If that's not enough, .gitattributes can be used to mark
> certain files as 'big'.
>
> See below link for recent discussions regarding big file support:
>
> http://thread.gmane.org/gmane.comp.version-control.git/165389/focus=3D=
168956
>
> On the store of big files, bup (at github) model might fit in as well
> if large files change a small portion regularly.
> --
> Duy
>
But, why those features haven't merged into upstream developement?
Sorry for this question, but I'm fresh here.
