From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Git files data formats documentation
Date: Sat, 05 Aug 2006 13:15:14 -0700
Message-ID: <44D4FC52.6030807@gmail.com>
References: <44D42F0D.3040707@gmail.com> <eb2onf$7up$1@sea.gmane.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 05 22:15:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9SYL-0001Fj-RE
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 22:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWHEUPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 16:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWHEUPS
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 16:15:18 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:37580 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932398AbWHEUPS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 16:15:18 -0400
Received: by py-out-1112.google.com with SMTP id z74so651355pyg
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:15:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HvGLeb+cLhtOibnEIm6oKW8sSC2QE5XDr7DfEOX/FeUsShqdIXRJj9B8NUEoTpHksQp3IZzA4ME1W8aVdvhlHzL75j+ZWSagGiBSeDNy+XUIRSdfCasoOtVuDDGr424sPfnG7K4mMqiAArWtwrgpiIYl6GIJd4cAd7Mre4bNzXE=
Received: by 10.35.9.15 with SMTP id m15mr8108062pyi;
        Sat, 05 Aug 2006 13:15:16 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.32.187.210])
        by mx.gmail.com with ESMTP id i72sm1878196pye.2006.08.05.13.15.15;
        Sat, 05 Aug 2006 13:15:15 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <eb2onf$7up$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24930>

Jakub Narebski wrote:
> A Large Angry SCM wrote:
> 
>> <TREE_ENTRY>
>>         # The type of the object referenced MUST be appropriate for
>>         # the mode. Regular files and symbolic links reference a BLOB
>>         # and directories reference a TREE.
>>         :       <OCTAL_MODE> <SP> <NAME> <NUL> <BINARY_OBJ_ID>
>>         ;
> [...]
>> <OCTAL_MODE>
>>         # Octal encoding, without prefix, of the file system object
>>         # type and permission bits. The bit layout is according to the
>>         # POSIX standard, with only regular files, directories, and
>>         # symbolic links permitted. The actual permission bits are
>>         # all zero except for regular files. The only permission bit
>>         # of any consequence to Git is the owner executable bit. By
>>         # default, the permission bits for files will be either 0644
>>         # or 0755, depending on the owner executable bit.
>>         ;
> 
> I do wonder why there is <OCTAL_MODE> (and not <BINARY_OCTAL_MODE>) 
> but <BINARY_OBJ_ID> (and not <HEX_OBJ_ID>).
> 

<OCTAL_MODE> because it's an ASCII string. <BINARY_OBJ_ID> because it's 
the 20 byte digest.
