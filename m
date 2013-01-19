From: Eric James Michael Ritz <lobbyjones@gmail.com>
Subject: Re: [RFC] git rm -u
Date: Sat, 19 Jan 2013 17:01:01 -0500
Message-ID: <50FB179D.7010006@gmail.com>
References: <50FB1196.2090309@gmail.com> <20130119214921.GE4009@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tomas Carnecky <tomas.carnecky@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 23:08:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twgao-0004Pc-S2
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 23:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab3ASWIa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 17:08:30 -0500
Received: from mail-ye0-f176.google.com ([209.85.213.176]:61301 "EHLO
	mail-ye0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab3ASWI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 17:08:29 -0500
Received: by mail-ye0-f176.google.com with SMTP id m1so733607yen.7
        for <git@vger.kernel.org>; Sat, 19 Jan 2013 14:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=AP2cQygHoLlirajcUiilvhiUFtsB4EGhgpbDhjkUuUg=;
        b=TL1yFWyMU92FrebbSnG47oWi81KwiAPP0CRrG9rS9e9XbbkwV+toio3vq86Zcoy4ab
         /5kd1soNmzaRyQ67UkCvGGNnBcpa3rrZ5bQVXITEPTqk1qmpANeXUygsuAg+n/Ez1foQ
         Zjdlc+dEqSxqWJ1VUhxo7skQ9DisXLGnGsVtmgxPijTHehkzxJxKmIrBFPmFTf0KTt6w
         woqzg5sMYitDl7Vj9vho+yJk9G6gw/MJ9wirSYJm9Eu9u9R4qBddQ3j+Cgo+xppJ4vcS
         Yaztk2xUWnvZmcC8ggQtwDmfgFQHQLksfbkmad7qHInMoJ7SFMhXwjVLVA2pkNaxk7TT
         ks7g==
X-Received: by 10.236.147.204 with SMTP id t52mr15868119yhj.9.1358632862498;
        Sat, 19 Jan 2013 14:01:02 -0800 (PST)
Received: from [192.168.1.102] (97-81-212-183.dhcp.hckr.nc.charter.com. [97.81.212.183])
        by mx.google.com with ESMTPS id s30sm8665976yhl.21.2013.01.19.14.01.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jan 2013 14:01:01 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130119214921.GE4009@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213994>

On 01/19/2013 04:49 PM, Jonathan Nieder wrote:
 > Eric James Michael Ritz wrote:
 >
 >> When I came to my senses and realized that does not work I began to
 >> wonder if `git rm -u` should exist.  If any deleted, tracked files
 >> are not part of the index to commit then `git rm -u` would add that
 >> change to the index.
 >
 > I like it.  If you have time to write such a patch, I'll be happy to
 > read it.

Thank you for the offer Jonathan.  I must go ahead and apologize for
my rusty ability with C; I haven=E2=80=99t needed to use the language i=
n
years.  But I will familiarize myself with the Git source and try to
put a patch (or series of patches) together over the next week or two.

--
ejmr
=E5=8D=97=E7=84=A1=E5=A6=99=E6=B3=95=E8=93=AE=E8=8F=AF=E7=B6=93
