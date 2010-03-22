From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 22 Mar 2010 11:48:38 +0800
Message-ID: <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	 <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	 <4BA544FC.7050007@gmail.com>
	 <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
	 <4BA61CF9.7040104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Mon Mar 22 04:48:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtYdJ-0000OZ-I9
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 04:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074Ab0CVDsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 23:48:40 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:44021 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711Ab0CVDsj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 23:48:39 -0400
Received: by qyk9 with SMTP id 9so2979217qyk.1
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 20:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=vP1CgRKKIZWjAeVdOl1WWeaazaIxXp21rViiLgsUqZc=;
        b=bGUchpr2pkGhm9AAgygha4/v93Tqwgnc3ISozPogAedfjm61TSP+6SEuRz1sumZchG
         l17rDVHtQ/QO94fdWdCU1hC95vSh4MDs7PIn646gcD2EsbpbMUioBOsLaXWWFFJ9gH47
         NU0938cEM4nrONo/v0TIQ9nFxKwUw/zaqatxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mwMQ3T/Bypxl8AnnIIi0KmiAxz7kJ9ETu1Msnu7KyjqfpqjwNyTDwgeb6e6ayYNyjv
         mmPDAAuMmGcVJvK1kBG4b06OK0wuhCkBC35C5uC//W2nXBE31neFwvoEx3CRbTwDfijy
         iBdKZM6olgPse5e2fEaMFDD1Osf/4Sk9dEToI=
Received: by 10.229.227.5 with SMTP id iy5mr415349qcb.29.1269229718400; Sun, 
	21 Mar 2010 20:48:38 -0700 (PDT)
In-Reply-To: <4BA61CF9.7040104@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142891>

On Sun, Mar 21, 2010 at 9:19 PM, A Large Angry SCM <gitzilla@gmail.com> wrote:
> Bo Yang wrote:
> [...]
>>
>> For multiple ranges stuff, I don't think it is very useful to support
>> it for a history browser. Anyway, our users can only focus on one line
>> of thread history. I am very willing to listen what is your use case
>> for a multiple ranges?
>
> More than one line range can be related and of interest to a
> forensics/archeology task.
>
> In a simple multi range case, you'd have 2 line ranges in the same file that
> you want to see the history and graph of. Such as 2 related macro
> definitions in a header file.
>
> In a complex multi range case, you'd have many line ranges spread over
> multiple blobs and some of the blobs have disjoint commit graphs.
>
> The complex multi range case may be too much for a GSOC project, and the
> simple multi range case may be also. However, the command syntax should be
> general enough to handle them without being too ugly so that the
> implementation could be improved and expanded later.

Yeah, how do you think use the following syntax:

<file1>@<rev1>:<start pos>,<end pos> <file2>@<rev2>:<start pos>,<end pos>

Thanks!

Regards!
Bo
