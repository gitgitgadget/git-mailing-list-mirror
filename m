From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Merging in Subversion 1.5
Date: Fri, 28 Aug 2009 16:34:30 +0000
Message-ID: <32541b130908280934m67a86837pb53f5effc0f514bd@mail.gmail.com>
References: <4A979690.1050601@gnu.org> <m3ocq0km5m.fsf_-_@localhost.localdomain> 
	<32541b130908280829s6fcebbe5ja84b10e649de1eb3@mail.gmail.com> 
	<200908281819.10135.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthias Andree <matthias.andree@gmx.de>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 18:35:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh4Py-0006Ug-OG
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 18:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbZH1Qet convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2009 12:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbZH1Qes
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 12:34:48 -0400
Received: from mail-gx0-f205.google.com ([209.85.217.205]:40916 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbZH1Qes convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Aug 2009 12:34:48 -0400
Received: by gxk1 with SMTP id 1so2583592gxk.17
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 09:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=7iuUBrJq0CJi16jkgo2k1QsJq3duVLYVdLNyiau5WbQ=;
        b=HnSy3w0ocewj90FP5DLRlfKkO6TtE8FYrQSHzYvM/ntwNXI/3xsgyN2xwkZe4VVtMa
         FYbeEPqFTafUsheEo2iaygAOxI0XKFBn7leaTNHmxdD99rJRlj3GirfIhfdJKO9tG4B0
         qO3xZYKJ/Jv+q3CZO/A90IDWyc7IvAcpYJlcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=b4VZjO9hmw73qRzL7LmFc6yO449A/zY0aqfTXlyMBZyyk9bAZ7xzowqDVtDhH5+n/M
         Q4G0rt/CDVpqd4HMGucAKgfVLqJJEPevEvWp8BiDxtYLyeMEtc6/esczozeskRRG3Hkn
         oHTMY7+Cqd+j3/I622Brd9XaLhbB24bPJmO2k=
Received: by 10.150.243.15 with SMTP id q15mr1223088ybh.335.1251477290105; 
	Fri, 28 Aug 2009 09:34:50 -0700 (PDT)
In-Reply-To: <200908281819.10135.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127312>

On Fri, Aug 28, 2009 at 4:19 PM, Jakub Narebski<jnareb@gmail.com> wrote=
:
> On Fri, 28 Aug 2009, Avery Pennarun wrote:
>> On Fri, Aug 28, 2009 at 3:12 PM, Jakub Narebski<jnareb@gmail.com> wr=
ote:
>> > =A0* You have to explicitely enable using svn:mergeinfo in log and=
 blame
>>
>> Conversely, in git you can basically disable it using --first-parent=
,
>> which is sometimes handy. [...]
>
> In git-log. =A0But in git-blame?

I don't know about git-blame, as I rarely use it.  If it doesn't
support --first-parent, I imagine it would be easy to add, if it were
important to someone.

Avery
