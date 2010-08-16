From: David Scurrah <D.Scurrah@bom.gov.au>
Subject: Patch for git-completion.bash  [SEC=UNCLASSIFIED]
Date: Mon, 16 Aug 2010 10:53:07 +1000
Message-ID: <0E3686EB9FA8AA409AFA0A25468DCE4301309C3DE865@BOM-VMBX-HO.bom.gov.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
    boundary="_002_0E3686EB9FA8AA409AFA0A25468DCE4301309C3DE865BOMVMBXHObo_"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "spearce@spearce.org" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 16 03:03:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oko6n-0003kI-Qe
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 03:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823Ab0HPBDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Aug 2010 21:03:20 -0400
Received: from mgmtbom7.bom.gov.au ([134.178.63.157]:4564 "EHLO
	mgmtbom7.bom.gov.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab0HPBDU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 21:03:20 -0400
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Aug 2010 21:03:19 EDT
X-Protective-Marking: VER=2005.6, NS=gov.au, SEC=UNCLASSIFIED, 
    ORIGIN=D.Scurrah@bom.gov.au
Received: from BOM-CAS-HO2.bom.gov.au (bom-cas-ho2.bom.gov.au) by 
    mgmtbom7.bom.gov.au (Clearswift SMTPRS 5.2.5) with ESMTP id 
    <T9786f0c97386b23f9da38@mgmtbom7.bom.gov.au>; Mon, 16 Aug 2010 
    10:53:08 +1000
Received: from BOM-VMBX-HO.bom.gov.au ([fe80::e8b6:c91e:5d4a:2993]) by 
    BOM-CAS-HO2.bom.gov.au ([fe80::3dfa:9a29:fba2:d87e%16]) with mapi; 
    Mon, 16 Aug 2010 10:53:08 +1000
Thread-Topic: Patch for git-completion.bash [uncl]
Thread-Index: Acs83WQ63lxVsBCuQf6tyTrRDe9Xiw==
Accept-Language: en-US, en-AU
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, en-AU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153636>

--_002_0E3686EB9FA8AA409AFA0A25468DCE4301309C3DE865BOMVMBXHObo_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Cg==

--_002_0E3686EB9FA8AA409AFA0A25468DCE4301309C3DE865BOMVMBXHObo_
Content-Type: text/x-patch; 
    name="0001-Completion-script-fails-because-of-syntax-error.patch"
Content-Description:     0001-Completion-script-fails-because-of-syntax-error.patch
Content-Disposition: attachment; 
    filename="0001-Completion-script-fails-because-of-syntax-error.patch";
     size=985; creation-date="Mon, 16 Aug 2010 10:53:07 GMT"; 
    modification-date="Mon, 16 Aug 2010 10:53:07 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1OTNiOTJjMjJmYjcyODg0YzRkNjFlNmE0YWUxZGQ2NWRiODk0MjVmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBTY3VycmFoIDxkc2N1cnJhaEBib20uZ292LmF1PgpE
YXRlOiBNb24sIDE2IEF1ZyAyMDEwIDEwOjM1OjI4ICsxMDAwClN1YmplY3Q6IFtQQVRDSF0gQ29t
cGxldGlvbiBzY3JpcHQgZmFpbHMgYmVjYXVzZSBvZiBzeW50YXggZXJyb3IKCi0tLQogY29udHJp
Yi9jb21wbGV0aW9uL2dpdC1jb21wbGV0aW9uLmJhc2ggfCAgICAyICstCiAxIGZpbGVzIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9jb250cmli
L2NvbXBsZXRpb24vZ2l0LWNvbXBsZXRpb24uYmFzaCBiL2NvbnRyaWIvY29tcGxldGlvbi9naXQt
Y29tcGxldGlvbi5iYXNoCmluZGV4IDY3NTY5OTAuLjY0YjRmMDkgMTAwNzU1Ci0tLSBhL2NvbnRy
aWIvY29tcGxldGlvbi9naXQtY29tcGxldGlvbi5iYXNoCisrKyBiL2NvbnRyaWIvY29tcGxldGlv
bi9naXQtY29tcGxldGlvbi5iYXNoCkBAIC0xMjAsNyArMTIwLDcgQEAgX19naXRfcHMxX3Nob3df
dXBzdHJlYW0gKCkKIAkJCXVwc3RyZWFtPXN2bitnaXQgIyBkZWZhdWx0IHVwc3RyZWFtIGlzIFNW
TiBpZiBhdmFpbGFibGUsIGVsc2UgZ2l0CiAJCQk7OwogCQllc2FjCi0JZG9uZSA8IDwoZ2l0IGNv
bmZpZyAteiAtLWdldC1yZWdleHAgJ14oc3ZuLXJlbW90ZVwuLipcLnVybHxiYXNoXC5zaG93dXBz
dHJlYW0pJCcgMj4vZGV2L251bGwgfCB0ciAnXDBcbicgJ1xuICcpCisJZG9uZSA8ICQoZ2l0IGNv
bmZpZyAteiAtLWdldC1yZWdleHAgJ14oc3ZuLXJlbW90ZVwuLipcLnVybHxiYXNoXC5zaG93dXBz
dHJlYW0pJCcgMj4vZGV2L251bGwgfCB0ciAnXDBcbicgJ1xuICcpCiAKIAkjIHBhcnNlIGNvbmZp
Z3VyYXRpb24gdmFsdWVzCiAJZm9yIG9wdGlvbiBpbiAke0dJVF9QUzFfU0hPV1VQU1RSRUFNfTsg
ZG8KLS0gCjEuNy4wLjEKCg==

--_002_0E3686EB9FA8AA409AFA0A25468DCE4301309C3DE865BOMVMBXHObo_--
