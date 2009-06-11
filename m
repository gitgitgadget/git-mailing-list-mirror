From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [RFC/PATCH 1/2] Teach Solaris that _XOPEN_SOURCE=600 really menas XPG6
Date: Thu, 11 Jun 2009 19:36:15 +0200
Message-ID: <4F909897-DD86-4C35-B18F-BE1CFBF06FAE@dbservice.com>
References: <1243106697-6424-1-git-send-email-gitster@pobox.com> <1243106697-6424-2-git-send-email-gitster@pobox.com> <B96700A1-EC8C-4DDE-A158-CE298FCCA09F@dbservice.com> <bUVdoksYaP8iWWwjmEaaKuJWLMjhg9vaKu35QNnhoSMM0G7B3XoanQ@cipher.nrlssc.navy.mil> <BDDDCC14-2EC0-4F34-AACE-0B0A3D8481B8@dbservice.com> <UBftUjN2Jk2tj73et7i3WvuSUhtOiNjPVjmux6IKeXOo0Zs8KHgrOA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jun 11 19:36:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEoCo-0007cM-At
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 19:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbZFKRgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 13:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbZFKRgl
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 13:36:41 -0400
Received: from office.neopsis.com ([78.46.209.98]:45611 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbZFKRgl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 13:36:41 -0400
Received: from calvin.emmen.dbservice.com ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES128-SHA (128 bits));
	Thu, 11 Jun 2009 19:36:41 +0200
In-Reply-To: <UBftUjN2Jk2tj73et7i3WvuSUhtOiNjPVjmux6IKeXOo0Zs8KHgrOA@cipher.nrlssc.navy.mil>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121353>


On Jun 11, 2009, at 7:13 PM, Brandon Casey wrote:
> Ok, great.  Looks like Sun fixed the flaw that was present in the 5.8
> compiler, and no other changes need to be made to git.  To be  
> absolutely
> sure, and if you have a moment, can you try to compile the code  
> snippet at
> the end of this email?
>
> If you name the saved the code "test.c", then just compile with
>
>   /opt/SUNWspro/bin/c99 -c test.c
>
> The Sun C 5.8 compiler complains like this for me:
>
>   "test.c", line 12: identifier redeclared: test_func
>           current : function(pointer to const struct a_struct {int  
> b, array[-1] of pointer to char c}) returning pointer to void
>           previous: function(pointer to const struct a_struct {int  
> b, array[-1] of pointer to char c}) returning pointer to void :  
> "test.c", line 4
>   c99: acomp failed for test.c
>
> If the 5.9 compiler successfully compiles it, then this new version  
> of Sun's
> compiler correctly handles c99 flex arrays.

It compiles without errors.

tom
