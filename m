From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Unexpected cherry-pick behaviour
Date: Mon, 16 Dec 2013 19:00:53 -0000
Organization: OPDS
Message-ID: <B4E4F29CB20847DEB23F21255A040187@PhilipOakley>
References: <118044938ad8ebf6b069bcc1d220a986@matos-sorge.com><xmqqvbywts9d.fsf@gitster.dls.corp.google.com><7050e7272bb83d083a56a2c391228ed8@matos-sorge.com><CALWbr2zPPnDiv7oVBhnM9dSW=pfz2jUA_A5u_gk2ttgXTStvkw@mail.gmail.com><beee32a53ece8b839578703deb851eaa@matos-sorge.com><CALWbr2y1YDX0dzjpZoF8WL4+ND+8drurH+Wrf1wBs_-=0datOA@mail.gmail.com><3FFF08967D2E480FA6B0E0EE3A72A8D9@PhilipOakley> <7vmwk3gr39.fsf@alter.siamese.dyndns.org> <0172E9F1B5F945EB9294F1066C2FB72E@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "Antoine Pelisse" <apelisse@gmail.com>,
	"Paulo Matos" <paulo@matos-sorge.com>, "git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Dec 16 20:00:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsdOd-00014g-CL
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 20:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193Ab3LPS77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 13:59:59 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:61147 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754466Ab3LPS76 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Dec 2013 13:59:58 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApEYALRMr1JZ8YR9/2dsb2JhbABZgwqBAQEBiEuwLAECAQGBJhd0aQEBgR8BARQBBAEBAQECAQgBAS4eAQEcBQsCAwUCAQMVDCUUAQQaBgcXBhMIAgECAwGFOAcBghIZDMhOjxmDKoETBIkLhhOaKWODKjw
X-IPAS-Result: ApEYALRMr1JZ8YR9/2dsb2JhbABZgwqBAQEBiEuwLAECAQGBJhd0aQEBgR8BARQBBAEBAQECAQgBAS4eAQEcBQsCAwUCAQMVDCUUAQQaBgcXBhMIAgECAwGFOAcBghIZDMhOjxmDKoETBIkLhhOaKWODKjw
X-IronPort-AV: E=Sophos;i="4.95,496,1384300800"; 
   d="scan'208";a="450051687"
Received: from host-89-241-132-125.as13285.net (HELO PhilipOakley) ([89.241.132.125])
  by out1.ip01ir2.opaltelecom.net with SMTP; 16 Dec 2013 18:59:57 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239344>

From: "Philip Oakley" <philipoakley@iee.org>
> From: "Junio C Hamano" <gitster@pobox.com>, Saturday, December 14, 
> 2013 7:39 PM
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> Would this be a good use of the
>>>    * Magic pathspecs like ":(icase)
>>> that was recently released (v1.8.5  2Dec13)  so that the merge 
>>> stages
>>> can be named.
>>
>> Because the pathspec mechahism is for you to tell an operation that
>> works on a collection of paths (e.g. "all the paths in the HEAD",
>> "all the paths at stage #1 in the index") to narrow the set it
>> operates on down to only those that match, I do not think it is a
>> good match at all to what you are trying to do.
>>
>
> My point was that the ":1:" syntax already was a "path at stage #1 in 
> the index" indicator, and that it would be good to have a memorable 
> name for the :1:2:3: stages as per Antoine's  query.

Could someone point me at where is this syntax decoded?
My initial hunt around the code base didn't find the relevant location.

>
> It maybe that my referring to it as a 'magic pathspec' was a mistake, 
> but the difficulty of remembering which number is ours:theirs:base 
> still stands.
>
> (for general info; the :<stage>:  format is defined in 'git revision 
> (7)' as the last method for Specifying Revisions)
>
> Philip
> --
Philip
