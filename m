From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 06/13] delete_refs(): convert error message to lower case
Date: Tue, 09 Jun 2015 12:23:12 +0200
Message-ID: <5576BE90.8050307@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu>	<49bd60449c003c8a7fd060095fe743bb9efaba99.1433763494.git.mhagger@alum.mit.edu> <CAGZ79kbT3x=CxKwwxk8qsfNh5ee-0i2Toe4sY584CkjbadDGjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 12:23:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Ggt-00019B-GY
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 12:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932910AbbFIKX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 06:23:28 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:45450 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753794AbbFIKX0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 06:23:26 -0400
X-AuditID: 1207440f-f79236d000000c5e-69-5576be928d41
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 07.0E.03166.29EB6755; Tue,  9 Jun 2015 06:23:15 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97525.dip0.t-ipconnect.de [79.201.117.37])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t59ANCxW015934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 9 Jun 2015 06:23:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <CAGZ79kbT3x=CxKwwxk8qsfNh5ee-0i2Toe4sY584CkjbadDGjA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqDt5X1mowaowi64r3UwWDb1XmC1+
	tPQwW2ze3M7iwOKxYFOpx7PePYweFy8pe3zeJBfAEsVtk5RYUhacmZ6nb5fAndGy7yp7wSTW
	iq53R5gaGLtZuhg5OCQETCTuzk3qYuQEMsUkLtxbzwZiCwlcZpRYPUmki5ELyD7HJDHz9wRG
	kASvgLbE6zMn2EF6WQRUJfrPJoCE2QR0JRb1NDOBhEUFgiRev8yFqBaUODnzCQuILSKgJjFz
	1Wyw8cwC5RJ/Li9iB7GFBXwlLk7rZYZYdZpR4uu0K2CrOAUCJX5e2MYM0aAu8WfeJShbXmL7
	2znMExgFZiHZMQtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zro5WaW6KWmlG5i
	hIQx/w7GrvUyhxgFOBiVeHhPKJSFCrEmlhVX5h5ilORgUhLl/b0SKMSXlJ9SmZFYnBFfVJqT
	WnyIUYKDWUmEl6ULKMebklhZlVqUD5OS5mBREudVX6LuJySQnliSmp2aWpBaBJOV4eBQkuC1
	2gvUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K0vhiYJyCpHiA9uaAtPMWFyTm
	AkUhWk8x6nLcmfJ/EZMQS15+XqqUOG8KSJEASFFGaR7cCljSesUoDvSxMO9lkCoeYMKDm/QK
	aAkT0JLvX4tBlpQkIqSkGhiLsvQL5v7iTP55a/KG0Mduzoeffk1X3CDaeCo2emOwV7gGp+7h
	vAdsl9YnS7QWLV8v9Ux69j+WeVEKgutnO9VwX354pmG3j/LllRdWFKi80e6Oj+ir 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271162>

On 06/08/2015 06:51 PM, Stefan Beller wrote:
> On Mon, Jun 8, 2015 at 4:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> This string is going to have to be re-internationalized anyway because
>> of the previous commit. So while we're at it, we might as well convert
>> it to lower case as per our usual practice.
> 
> Although the previous patch and this are addressing two slightly
> different things,
> we may want to squash this into the previous without dropping any of
> the commit message?
> (It might make reviewing easier, I'd assume)

OK, I will squash them together.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
